import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/job_application.dart';
import 'package:farmmitra_app/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:farmmitra_app/shared/widgets/app_empty_state.dart';
import 'package:farmmitra_app/shared/widgets/app_loading_view.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationsPage extends ConsumerWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsState = ref.watch(jobsControllerProvider);
    final role = ref.watch(authControllerProvider).selectedRole;

    return AppPageScaffold(
      title: role == UserRole.farmer ? 'Applicants' : 'Applications',
      body: jobsState.applications.isEmpty
          ? jobsState.isLoading
                ? const AppLoadingView(message: 'Loading applications...')
                : AppEmptyState(
                    icon: Icons.fact_check_outlined,
                    title: role == UserRole.farmer
                        ? 'No applicants yet'
                        : 'No applications yet',
                    message: role == UserRole.farmer
                        ? 'When workers apply for your posted jobs, their requests will appear here.'
                        : 'Apply to a nearby farm job and your request will be saved here, even offline.',
                  )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final application = jobsState.applications[index];
                final job = _findJobTitle(jobsState.jobs, application.jobId);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.fact_check_outlined),
                          title: Text(job ?? 'Job ${application.jobId}'),
                          subtitle: Text(
                            role == UserRole.farmer
                                ? 'Worker: ${application.workerLocalUserId}'
                                : application.status.label,
                          ),
                          trailing: Chip(
                            label: Text(application.status.label),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        if (application.message?.isNotEmpty == true)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(application.message!),
                          ),
                        if (role == UserRole.farmer)
                          _FarmerApplicationActions(application: application),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemCount: jobsState.applications.length,
            ),
    );
  }
}

class _FarmerApplicationActions extends ConsumerWidget {
  const _FarmerApplicationActions({required this.application});

  final JobApplication application;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canDecide = application.status == JobApplicationStatus.pending;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: canDecide
                ? () => ref
                      .read(jobsControllerProvider.notifier)
                      .updateApplicationStatus(
                        application: application,
                        status: JobApplicationStatus.rejected,
                      )
                : null,
            icon: const Icon(Icons.close),
            label: const Text('Reject'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FilledButton.icon(
            onPressed: canDecide
                ? () => ref
                      .read(jobsControllerProvider.notifier)
                      .updateApplicationStatus(
                        application: application,
                        status: JobApplicationStatus.accepted,
                      )
                : null,
            icon: const Icon(Icons.check),
            label: const Text('Accept'),
          ),
        ),
      ],
    );
  }
}

String? _findJobTitle(List<FarmJob> jobs, String jobId) {
  for (final job in jobs) {
    if (job.id == jobId) {
      return job.title;
    }
  }
  return null;
}
