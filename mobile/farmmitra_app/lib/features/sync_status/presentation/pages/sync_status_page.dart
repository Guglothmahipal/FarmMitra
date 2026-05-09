import 'package:farmmitra_app/core/sync/queued_sync_request.dart';
import 'package:farmmitra_app/core/sync/sync_providers.dart';
import 'package:farmmitra_app/core/sync/sync_status.dart';
import 'package:farmmitra_app/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:farmmitra_app/shared/widgets/app_empty_state.dart';
import 'package:farmmitra_app/shared/widgets/app_loading_view.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:farmmitra_app/shared/widgets/sync_queue_summary_card.dart';
import 'package:farmmitra_app/shared/widgets/sync_visibility_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncStatusPage extends ConsumerWidget {
  const SyncStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingSyncRequestsProvider);
    final jobsState = ref.watch(jobsControllerProvider);
    final profileState = ref.watch(profileControllerProvider);
    final failedJobs = jobsState.jobs
        .where((job) => job.syncStatus == SyncStatus.failed)
        .length;
    final failedApplications = jobsState.applications
        .where((application) => application.syncStatus == SyncStatus.failed)
        .length;
    final pendingProfile = profileState.profile?.needsSync == true ? 1 : 0;

    return AppPageScaffold(
      title: 'Offline Sync',
      body: requestsAsync.when(
        data: (requests) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SyncVisibilityBanner(),
            const SizedBox(height: 12),
            SyncQueueSummaryCard(
              requests: requests,
              onRetry: () => _retryQueue(context, ref, requests),
            ),
            const SizedBox(height: 12),
            _DatabaseStatusCard(
              pendingJobs: jobsState.jobs
                  .where((job) => job.syncStatus == SyncStatus.pending)
                  .length,
              pendingApplications: jobsState.applications
                  .where(
                    (application) =>
                        application.syncStatus == SyncStatus.pending,
                  )
                  .length,
              pendingProfile: pendingProfile,
              failedJobs: failedJobs,
              failedApplications: failedApplications,
            ),
            const SizedBox(height: 12),
            if (failedJobs + failedApplications > 0)
              const _FailedSyncWarning()
            else if (requests.isEmpty)
              const AppEmptyState(
                icon: Icons.cloud_done_outlined,
                title: 'All local work is settled',
                message:
                    'No pending offline changes are waiting right now. New edits will appear here before sync.',
              )
            else
              _QueuedActionList(requests: requests),
            const SizedBox(height: 12),
            const _SyncHistoryPlaceholder(),
          ],
        ),
        error: (_, _) => const AppEmptyState(
          icon: Icons.sync_problem_outlined,
          title: 'Could not load sync queue',
          message: 'Please try again after reopening this screen.',
        ),
        loading: () => const AppLoadingView(message: 'Checking sync status...'),
      ),
    );
  }

  Future<void> _retryQueue(
    BuildContext context,
    WidgetRef ref,
    List<QueuedSyncRequest> requests,
  ) async {
    for (final request in requests.take(3)) {
      await ref
          .read(syncQueueLocalDataSourceProvider)
          .markAttempted(request.id);
    }
    ref.invalidate(pendingSyncRequestsProvider);
    ref.invalidate(pendingSyncQueueCountProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Retry placeholder recorded for queued actions.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _DatabaseStatusCard extends StatelessWidget {
  const _DatabaseStatusCard({
    required this.pendingJobs,
    required this.pendingApplications,
    required this.pendingProfile,
    required this.failedJobs,
    required this.failedApplications,
  });

  final int pendingJobs;
  final int pendingApplications;
  final int pendingProfile;
  final int failedJobs;
  final int failedApplications;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.storage_outlined),
                const SizedBox(width: 8),
                Text(
                  'Local database status',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _StatusChip(label: 'Jobs pending', count: pendingJobs),
                _StatusChip(
                  label: 'Applications pending',
                  count: pendingApplications,
                ),
                _StatusChip(label: 'Profile updates', count: pendingProfile),
                if (failedJobs + failedApplications > 0)
                  _StatusChip(
                    label: 'Failed',
                    count: failedJobs + failedApplications,
                    isWarning: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QueuedActionList extends StatelessWidget {
  const _QueuedActionList({required this.requests});

  final List<QueuedSyncRequest> requests;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Retry queue', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final request in requests.take(6))
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(_iconForEndpoint(request.endpoint)),
                title: Text(_labelForEndpoint(request.endpoint)),
                subtitle: Text(
                  'Attempts: ${request.attemptCount} - ${_formatTime(request.createdAt)}',
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _iconForEndpoint(String endpoint) {
    if (endpoint.contains('/applications')) {
      return Icons.fact_check_outlined;
    }
    if (endpoint.contains('/profiles')) {
      return Icons.account_circle_outlined;
    }
    if (endpoint.contains('/jobs')) {
      return Icons.work_outline;
    }
    return Icons.sync;
  }

  String _labelForEndpoint(String endpoint) {
    if (endpoint.contains('/applications')) {
      return 'Job application sync';
    }
    if (endpoint.contains('/profiles')) {
      return 'Profile update sync';
    }
    if (endpoint.contains('/jobs')) {
      return 'Job update sync';
    }
    return 'Local action sync';
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _FailedSyncWarning extends StatelessWidget {
  const _FailedSyncWarning();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.warning_amber_outlined),
        title: Text('Some local changes need attention'),
        subtitle: Text(
          'Failed sync items remain safely stored. Retry will be available when backend sync is connected.',
        ),
      ),
    );
  }
}

class _SyncHistoryPlaceholder extends StatelessWidget {
  const _SyncHistoryPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.history_outlined),
        title: Text('Sync history'),
        subtitle: Text(
          'Successful backend sync records will appear here in a future release.',
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.count,
    this.isWarning = false,
  });

  final String label;
  final int count;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        isWarning ? Icons.error_outline : Icons.cloud_upload_outlined,
        size: 18,
      ),
      label: Text('$label: $count'),
      visualDensity: VisualDensity.compact,
    );
  }
}
