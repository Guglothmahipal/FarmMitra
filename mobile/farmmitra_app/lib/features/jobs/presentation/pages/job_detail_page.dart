import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:farmmitra_app/features/jobs/presentation/widgets/job_card.dart';
import 'package:farmmitra_app/shared/widgets/app_empty_state.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:farmmitra_app/shared/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobDetailPage extends ConsumerWidget {
  const JobDetailPage({required this.jobId, super.key});

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authControllerProvider).selectedRole;
    final jobsState = ref.watch(jobsControllerProvider);
    FarmJob? job;
    for (final item in jobsState.jobs) {
      if (item.id == jobId) {
        job = item;
        break;
      }
    }

    if (job == null) {
      return const AppPageScaffold(
        title: 'Job details',
        body: AppEmptyState(
          icon: Icons.search_off,
          title: 'Job not found',
          message: 'This job may have been changed or removed from local data.',
        ),
      );
    }

    final currentJob = job;
    final applied = jobsState.applications.any(
      (application) => application.jobId == currentJob.id,
    );

    return AppPageScaffold(
      title: 'Job details',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          JobCard(job: currentJob),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Work description',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(currentJob.description),
                ],
              ),
            ),
          ),
          if (role == UserRole.worker) ...[
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: applied || !currentJob.canApply
                  ? null
                  : () {
                      _showApplySheet(context, ref, currentJob);
                    },
              icon: Icon(applied ? Icons.check : Icons.send_outlined),
              label: Text(applied ? 'Already applied' : 'Apply for this job'),
            ),
          ] else ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonalIcon(
                  onPressed: currentJob.status == JobStatus.archived
                      ? null
                      : () => _confirmStatus(
                          context,
                          ref,
                          currentJob,
                          JobStatus.archived,
                        ),
                  icon: const Icon(Icons.archive_outlined),
                  label: const Text('Archive'),
                ),
                OutlinedButton.icon(
                  onPressed: currentJob.status == JobStatus.filled
                      ? null
                      : () => _confirmStatus(
                          context,
                          ref,
                          currentJob,
                          JobStatus.filled,
                        ),
                  icon: const Icon(Icons.task_alt),
                  label: const Text('Mark filled'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _confirmStatus(
    BuildContext context,
    WidgetRef ref,
    FarmJob job,
    JobStatus status,
  ) async {
    final confirmed = await showConfirmationDialog(
      context: context,
      title: '${status.label} job?',
      message: 'This will update the job locally and queue it for sync.',
      confirmLabel: status.label,
    );

    if (confirmed) {
      await ref
          .read(jobsControllerProvider.notifier)
          .setJobStatus(job: job, status: status);
    }
  }

  Future<void> _showApplySheet(
    BuildContext context,
    WidgetRef ref,
    FarmJob job,
  ) async {
    final messageController = TextEditingController();
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 4,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apply for ${job.title}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('${job.location} - Rs ${job.wage}/day'),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                dense: true,
                leading: Icon(Icons.offline_bolt_outlined),
                title: Text('Offline application'),
                subtitle: Text(
                  'This request will be stored locally and synced later.',
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: messageController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Message to farmer (optional)',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(jobsControllerProvider.notifier)
          .applyForJob(job, message: messageController.text);
      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application saved offline and queued for sync.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
