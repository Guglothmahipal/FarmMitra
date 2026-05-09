import 'dart:convert';

import 'package:farmmitra_app/core/sync/sync_status.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/job_application.dart';
import 'package:farmmitra_app/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:farmmitra_app/features/jobs/presentation/controllers/jobs_state.dart';
import 'package:farmmitra_app/features/jobs/presentation/providers/jobs_dependencies.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/local_notification.dart';
import 'package:farmmitra_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class JobsController extends Notifier<JobsState> {
  late final JobsRepository _repository;

  @override
  JobsState build() {
    _repository = ref.watch(jobsRepositoryProvider);
    ref.listen(authControllerProvider, (previous, next) {
      if (previous?.localUserId != next.localUserId ||
          previous?.selectedRole != next.selectedRole) {
        Future<void>.microtask(load);
      }
    });
    Future<void>.microtask(load);
    return const JobsState.initial();
  }

  Future<void> load() async {
    final authState = ref.read(authControllerProvider);
    final role = authState.selectedRole;
    final localUserId = authState.localUserId;

    if (!authState.isAuthenticated || role == null || localUserId == null) {
      state = state.copyWith(
        isLoading: false,
        jobs: const [],
        applications: const [],
        clearError: true,
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    final jobs = role == UserRole.farmer
        ? await _repository.readFarmerJobs(localUserId)
        : await _repository.readJobs();
    final applications = role == UserRole.worker
        ? await _repository.readWorkerApplications(localUserId)
        : await _repository.readFarmerApplications(localUserId);

    state = state.copyWith(
      isLoading: false,
      jobs: jobs,
      applications: applications,
    );
  }

  Future<bool> saveJob({
    required String? existingJobId,
    required String title,
    required String category,
    required String description,
    required String workType,
    required String notes,
    required int wage,
    required int workersRequired,
    required DateTime workDate,
    required String location,
  }) async {
    final localUserId = ref.read(authControllerProvider).localUserId;
    if (localUserId == null) {
      return false;
    }

    state = state.copyWith(isSaving: true, clearError: true);

    try {
      final existing = existingJobId == null
          ? null
          : await _repository.readJob(existingJobId);
      final now = DateTime.now();
      final job = FarmJob(
        id: existingJobId ?? 'job-$localUserId-${now.microsecondsSinceEpoch}',
        farmerLocalUserId: localUserId,
        title: title,
        category: category,
        description: description,
        workType: workType,
        notes: notes.isEmpty ? null : notes,
        wage: wage,
        workersRequired: workersRequired,
        workDate: workDate,
        location: location,
        status: existing?.status ?? JobStatus.open,
        syncStatus: SyncStatus.pending,
        needsSync: true,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );

      await _repository.saveJob(job);
      await _enqueueJobSync(job);
      await _addNotification(
        type: 'job_saved',
        title: existing == null ? 'Job created' : 'Job updated',
        body: '${job.title} was saved offline.',
      );
      await load();
      state = state.copyWith(isSaving: false);
      return true;
    } catch (_) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'Could not save job. Please try again.',
      );
      return false;
    }
  }

  Future<void> toggleJobStatus(FarmJob job) async {
    final nextStatus = job.status == JobStatus.open
        ? JobStatus.closed
        : JobStatus.open;
    await _repository.updateJobStatus(jobId: job.id, status: nextStatus);
    await _enqueueJobSync(job);
    await _addNotification(
      type: 'job_status_changed',
      title: 'Job ${nextStatus.label.toLowerCase()}',
      body: '${job.title} was marked ${nextStatus.label.toLowerCase()}.',
    );
    await load();
  }

  Future<void> setJobStatus({
    required FarmJob job,
    required JobStatus status,
  }) async {
    await _repository.updateJobStatus(jobId: job.id, status: status);
    await _enqueueJobSync(job);
    await _addNotification(
      type: 'job_status_changed',
      title: 'Job ${status.label.toLowerCase()}',
      body: '${job.title} was marked ${status.label.toLowerCase()}.',
    );
    await load();
  }

  Future<bool> applyForJob(FarmJob job, {String? message}) async {
    final localUserId = ref.read(authControllerProvider).localUserId;
    if (localUserId == null || !job.canApply) {
      return false;
    }

    final existing = await _repository.readApplicationForJob(
      jobId: job.id,
      workerLocalUserId: localUserId,
    );
    if (existing != null) {
      state = state.copyWith(errorMessage: 'You already applied for this job.');
      return false;
    }

    state = state.copyWith(isSaving: true, clearError: true);
    final now = DateTime.now();
    final application = JobApplication(
      id: 'application-${job.id}-$localUserId',
      jobId: job.id,
      workerLocalUserId: localUserId,
      status: JobApplicationStatus.pending,
      message: message?.trim().isEmpty == true ? null : message?.trim(),
      syncStatus: SyncStatus.pending,
      needsSync: true,
      createdAt: now,
      updatedAt: now,
    );

    await _repository.saveApplication(application);
    await _enqueueApplicationSync(application);
    await _addNotification(
      type: 'job_applied',
      title: 'Application saved',
      body: 'Your application for ${job.title} was saved offline.',
    );
    await load();
    state = state.copyWith(isSaving: false);
    return true;
  }

  bool hasApplied(String jobId) {
    return state.applications.any(
      (application) =>
          application.jobId == jobId &&
          application.status != JobApplicationStatus.withdrawn,
    );
  }

  Future<void> updateApplicationStatus({
    required JobApplication application,
    required JobApplicationStatus status,
  }) async {
    await _repository.updateApplicationStatus(
      applicationId: application.id,
      status: status,
    );
    await _enqueueApplicationSync(application);
    await _addNotification(
      type: 'application_${status.name}',
      title: 'Application ${status.label.toLowerCase()}',
      body:
          'Application for job ${application.jobId} was ${status.label.toLowerCase()}.',
    );
    await load();
  }

  void updateSearch(String value) {
    state = state.copyWith(searchQuery: value);
  }

  void updateLocationFilter(String value) {
    state = state.copyWith(locationFilter: value);
  }

  void updateCategoryFilter(String value) {
    state = state.copyWith(categoryFilter: value);
  }

  void updateMinimumWage(String value) {
    final wage = int.tryParse(value.trim());
    state = state.copyWith(
      minimumWage: wage,
      clearMinimumWage: value.trim().isEmpty,
    );
  }

  void updateOpenOnly(bool value) {
    state = state.copyWith(openOnly: value);
  }

  void updateFarmerStatusFilter(JobStatus? status) {
    state = state.copyWith(
      farmerStatusFilter: status,
      clearFarmerStatusFilter: status == null,
    );
  }

  Future<void> _enqueueJobSync(FarmJob job) {
    return ref
        .read(jobsSyncQueueProvider)
        .enqueue(
          id: 'job-${job.id}-${DateTime.now().millisecondsSinceEpoch}',
          method: 'PUT',
          endpoint: '/jobs/${job.id}',
          payload: jsonEncode({'type': 'job_update', 'job_id': job.id}),
        );
  }

  Future<void> _enqueueApplicationSync(JobApplication application) {
    return ref
        .read(jobsSyncQueueProvider)
        .enqueue(
          id: 'application-${application.id}-${DateTime.now().millisecondsSinceEpoch}',
          method: 'POST',
          endpoint: '/jobs/${application.jobId}/applications',
          payload: jsonEncode({
            'type': 'job_application',
            'application_id': application.id,
          }),
        );
  }

  Future<void> _addNotification({
    required String type,
    required String title,
    required String body,
  }) async {
    final localUserId = ref.read(authControllerProvider).localUserId;
    if (localUserId == null) {
      return;
    }

    final now = DateTime.now();
    await ref
        .read(notificationsRepositoryProvider)
        .saveNotification(
          LocalNotificationItem(
            id: 'notification-$localUserId-${now.microsecondsSinceEpoch}',
            localUserId: localUserId,
            type: type,
            title: title,
            body: body,
            isRead: false,
            syncStatus: SyncStatus.pending,
            createdAt: now,
          ),
        );
    ref.invalidate(notificationsControllerProvider);
  }
}
