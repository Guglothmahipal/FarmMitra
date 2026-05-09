import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/dashboard_card.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/dashboard_metric.dart';
import 'package:farmmitra_app/features/jobs/presentation/providers/jobs_providers.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authControllerProvider).selectedRole;

    return AppScaffold(
      title: AppConstants.appName,
      currentTab: AppTab.home,
      actions: [
        IconButton(
          tooltip: 'My Profile',
          onPressed: () => context.go(AppRoutes.profile),
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ],
      body: role == UserRole.worker
          ? const WorkerDashboardView()
          : const FarmerDashboardView(),
    );
  }
}

class FarmerDashboardView extends ConsumerWidget {
  const FarmerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider).profile?.farmer;
    final jobsState = ref.watch(jobsControllerProvider);
    final activeJobs = jobsState.openJobsCount;

    return RefreshIndicator(
      onRefresh: () => ref.read(jobsControllerProvider.notifier).load(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _WelcomeBanner(
            title: 'Namaste ${profile?.fullName ?? 'Farmer'}',
            subtitle: 'Manage labour demand, posted jobs, and farm work.',
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: [
              DashboardMetric(
                label: 'Active jobs',
                value: activeJobs.toString(),
                icon: Icons.assignment_outlined,
              ),
              DashboardMetric(
                label: 'Needs sync',
                value: jobsState.jobs
                    .where((job) => job.needsSync)
                    .length
                    .toString(),
                icon: Icons.cloud_upload_outlined,
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.jobCreate),
            icon: const Icon(Icons.add),
            label: const Text('Create Job'),
          ),
          const SizedBox(height: 12),
          DashboardCard(
            title: 'Posted jobs',
            subtitle: 'View, edit, close, or reopen your local job posts.',
            icon: Icons.work_outline,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(AppRoutes.jobs),
          ),
          const DashboardCard(
            title: 'Recent worker requests',
            subtitle: 'Worker interest and recommendations will appear here.',
            icon: Icons.groups_outlined,
          ),
          const DashboardCard(
            title: 'Upcoming work',
            subtitle: 'Scheduled labour and reminders will appear here.',
            icon: Icons.event_note_outlined,
          ),
          const DashboardCard(
            title: 'Farm summary',
            subtitle: 'Crop, land, and location intelligence placeholder.',
            icon: Icons.agriculture,
          ),
          const DashboardCard(
            title: 'Notifications',
            subtitle: 'SMS, push, and marketplace updates placeholder.',
            icon: Icons.notifications_outlined,
          ),
        ],
      ),
    );
  }
}

class WorkerDashboardView extends ConsumerWidget {
  const WorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider).profile?.worker;
    final jobsState = ref.watch(jobsControllerProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(jobsControllerProvider.notifier).load(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _WelcomeBanner(
            title: 'Namaste ${profile?.fullName ?? 'Worker'}',
            subtitle: 'Find nearby farm work and manage your applications.',
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: [
              DashboardMetric(
                label: 'Nearby jobs',
                value: jobsState.openJobsCount.toString(),
                icon: Icons.location_on_outlined,
              ),
              DashboardMetric(
                label: 'Applications',
                value: jobsState.applications.length.toString(),
                icon: Icons.fact_check_outlined,
              ),
            ],
          ),
          const SizedBox(height: 12),
          DashboardCard(
            title: 'Available jobs',
            subtitle: 'Browse local farm work and apply offline.',
            icon: Icons.work_outline,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(AppRoutes.jobs),
          ),
          DashboardCard(
            title: 'Availability',
            subtitle: profile?.isAvailable == true
                ? 'You are available for farm work.'
                : 'You are not marked available right now.',
            icon: Icons.event_available_outlined,
            onTap: () => context.go(AppRoutes.profileEdit),
          ),
          DashboardCard(
            title: 'Skills summary',
            subtitle:
                profile?.skills.join(', ') ?? 'Add skills in your profile.',
            icon: Icons.handyman_outlined,
            onTap: () => context.go(AppRoutes.profile),
          ),
          const DashboardCard(
            title: 'Recommended jobs',
            subtitle: 'GPS and AI recommendations will appear here.',
            icon: Icons.auto_awesome_outlined,
          ),
          const DashboardCard(
            title: 'Earnings',
            subtitle: 'Wage history and payout insights placeholder.',
            icon: Icons.currency_rupee,
          ),
          const DashboardCard(
            title: 'Notifications',
            subtitle: 'Job alerts and application updates placeholder.',
            icon: Icons.notifications_outlined,
          ),
        ],
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: scheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
