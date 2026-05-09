import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:farmmitra_app/features/jobs/presentation/widgets/job_card.dart';
import 'package:farmmitra_app/shared/widgets/app_empty_state.dart';
import 'package:farmmitra_app/shared/widgets/app_loading_view.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JobsPage extends ConsumerWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authControllerProvider).selectedRole;
    final jobsState = ref.watch(jobsControllerProvider);
    final isFarmer = role == UserRole.farmer;

    return AppScaffold(
      title: isFarmer ? 'My Jobs' : 'Available Jobs',
      currentTab: AppTab.jobs,
      actions: [
        if (isFarmer)
          IconButton(
            tooltip: 'Create Job',
            onPressed: () => context.push(AppRoutes.jobCreate),
            icon: const Icon(Icons.add),
          ),
      ],
      body: RefreshIndicator(
        onRefresh: () => ref.read(jobsControllerProvider.notifier).load(),
        child: jobsState.isLoading
            ? const AppLoadingView(message: 'Loading jobs...')
            : jobsState.filteredJobs.isEmpty
            ? _EmptyJobs(isFarmer: isFarmer)
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: jobsState.filteredJobs.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _JobFilters(isFarmer: isFarmer);
                  }
                  final job = jobsState.filteredJobs[index - 1];
                  return JobCard(
                    job: job,
                    onTap: () =>
                        context.push('${AppRoutes.jobDetails}/${job.id}'),
                    trailing: isFarmer
                        ? _FarmerJobActions(job: job)
                        : _WorkerJobActions(job: job),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 12),
              ),
      ),
    );
  }
}

class _EmptyJobs extends StatelessWidget {
  const _EmptyJobs({required this.isFarmer});

  final bool isFarmer;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppEmptyState(
          icon: Icons.work_outline,
          title: isFarmer ? 'No jobs posted yet' : 'No jobs found',
          message: isFarmer
              ? 'Create your first labour requirement and it will be saved offline.'
              : 'No open farm work is visible right now. Try another village, wage, or check again later.',
          action: isFarmer
              ? AppPrimaryButton(
                  label: 'Create Job',
                  icon: Icons.add,
                  onPressed: () => context.push(AppRoutes.jobCreate),
                )
              : null,
        ),
      ],
    );
  }
}

class _JobFilters extends ConsumerWidget {
  const _JobFilters({required this.isFarmer});

  final bool isFarmer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobsControllerProvider);
    final controller = ref.read(jobsControllerProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search jobs',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: controller.updateSearch,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Location'),
                    onChanged: controller.updateLocationFilter,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Min wage'),
                    keyboardType: TextInputType.number,
                    onChanged: controller.updateMinimumWage,
                  ),
                ),
              ],
            ),
            if (isFarmer) ...[
              const SizedBox(height: 8),
              DropdownButtonFormField<JobStatus?>(
                initialValue: state.farmerStatusFilter,
                decoration: const InputDecoration(labelText: 'Status'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('All')),
                  for (final status in JobStatus.values)
                    DropdownMenuItem(value: status, child: Text(status.label)),
                ],
                onChanged: controller.updateFarmerStatusFilter,
              ),
            ] else
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Open jobs only'),
                value: state.openOnly,
                onChanged: controller.updateOpenOnly,
              ),
          ],
        ),
      ),
    );
  }
}

class _FarmerJobActions extends ConsumerWidget {
  const _FarmerJobActions({required this.job});

  final FarmJob job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.push('${AppRoutes.jobEdit}/${job.id}'),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FilledButton.tonalIcon(
            onPressed: () {
              ref.read(jobsControllerProvider.notifier).toggleJobStatus(job);
            },
            icon: Icon(job.isOpen ? Icons.lock_outline : Icons.lock_open),
            label: Text(job.isOpen ? 'Close' : 'Open'),
          ),
        ),
      ],
    );
  }
}

class _WorkerJobActions extends ConsumerWidget {
  const _WorkerJobActions({required this.job});

  final FarmJob job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applied = ref
        .watch(jobsControllerProvider)
        .applications
        .any((application) => application.jobId == job.id);

    return FilledButton.icon(
      onPressed: applied || !job.canApply
          ? null
          : () {
              _showApplySheet(context, ref, job);
            },
      icon: Icon(applied ? Icons.check : Icons.send_outlined),
      label: Text(applied ? 'Applied' : 'Apply'),
    );
  }

  Future<void> _showApplySheet(
    BuildContext context,
    WidgetRef ref,
    FarmJob job,
  ) async {
    final messageController = TextEditingController();
    final applied = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
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
                  title: Text('Saved offline first'),
                  subtitle: Text(
                    'Your application stays on this phone and queues for sync.',
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
                  hintText: 'I am available for this work.',
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
        );
      },
    );

    if (applied == true && context.mounted) {
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
