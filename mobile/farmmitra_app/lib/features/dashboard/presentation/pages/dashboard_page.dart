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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAiPlaceholder(context),
        icon: const Icon(Icons.auto_awesome_outlined),
        label: const Text('Ask AI'),
      ),
      body: role == UserRole.worker
          ? const WorkerDashboardView()
          : const FarmerDashboardView(),
    );
  }

  void _showAiPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('FarmMitra AI assistant placeholder. Coming later.'),
        behavior: SnackBarBehavior.floating,
      ),
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          _WelcomeBanner(
            title: 'Namaste ${profile?.fullName ?? 'Farmer'}',
            subtitle: 'Farm work, labour planning, alerts, and tools.',
          ),
          const SizedBox(height: 14),
          const _WeatherCard(
            temperature: '31 C',
            rain: '35%',
            humidity: '62%',
            condition: 'Good for field work',
            workCondition: 'Harvest before evening rain',
          ),
          const SizedBox(height: 14),
          _MetricGrid(
            children: [
              DashboardMetric(
                label: 'Active jobs',
                value: activeJobs.toString(),
                icon: Icons.assignment_outlined,
              ),
              DashboardMetric(
                label: 'Nearby workers',
                value: '18',
                icon: Icons.groups_outlined,
              ),
            ],
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () => context.push(AppRoutes.jobCreate),
            icon: const Icon(Icons.add),
            label: const Text('Create Job'),
          ),
          const SizedBox(height: 18),
          const _SectionHeader(
            title: "Today's farm alerts",
            icon: Icons.notifications_active_outlined,
          ),
          const _AlertStrip(
            items: [
              _ChipItem('Light rain', Icons.water_drop_outlined),
              _ChipItem('Cotton watch', Icons.grass_outlined),
              _ChipItem('High labour demand', Icons.trending_up),
            ],
          ),
          const SizedBox(height: 18),
          _SectionHeader(
            title: 'Jobs and labour',
            icon: Icons.work_outline,
            actionLabel: 'View jobs',
            onAction: () => context.go(AppRoutes.jobs),
          ),
          DashboardCard(
            title: 'Active jobs',
            subtitle: 'Open, close, or edit your posted labour needs.',
            icon: Icons.work_outline,
            trailing: const Icon(Icons.chevron_right),
            voiceInstruction:
                'Open active jobs to manage labour work posted by you.',
            onTap: () => context.go(AppRoutes.jobs),
          ),
          const _PreviewList(
            title: 'Recommended labour',
            items: [
              _PreviewItem(
                icon: Icons.verified_user_outlined,
                title: 'Ramesh - Cotton harvest',
                subtitle: 'Rampur - 2 km',
                tag: 'Verified Worker',
              ),
              _PreviewItem(
                icon: Icons.star_outline,
                title: 'Lakshmi - Sowing team',
                subtitle: 'Kothapalli - 4 km',
                tag: 'Top Rated',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _SectionHeader(title: 'Crop and farm', icon: Icons.agriculture),
          DashboardCard(
            title: 'Crop summary',
            subtitle:
                profile?.preferredCrops.join(', ') ??
                'Add crops in profile for better suggestions.',
            icon: Icons.grass_outlined,
            onTap: () => context.go(AppRoutes.profile),
          ),
          const _ToolGrid(
            title: 'Farmer tools',
            tools: [
              _ToolItem('Crop planner', Icons.eco_outlined),
              _ToolItem('Irrigation', Icons.water_outlined),
              _ToolItem('Labour calculator', Icons.calculate_outlined),
              _ToolItem('Harvest planner', Icons.event_note_outlined),
              _ToolItem('Expense tracker', Icons.receipt_long_outlined),
              _ToolItem('Weather planning', Icons.wb_sunny_outlined),
            ],
          ),
          const SizedBox(height: 18),
          const _NewsSection(
            title: 'Market and mandi updates',
            items: [
              _NewsItem('Cotton mandi', 'Rs 7,120 / quintal nearby'),
              _NewsItem('Season tip', 'Prepare labour early for harvest week'),
              _NewsItem('Crop alert', 'Check leaves after humid mornings'),
            ],
          ),
          const SizedBox(height: 18),
          const _AiAssistantCard(
            title: 'Ask FarmMitra AI',
            subtitle: 'Get farm planning, labour, and crop help later.',
            suggestion: 'Try: How many workers for cotton harvest?',
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          _WelcomeBanner(
            title: 'Namaste ${profile?.fullName ?? 'Worker'}',
            subtitle: 'Nearby jobs, work conditions, earnings, and help.',
          ),
          const SizedBox(height: 14),
          const _WeatherCard(
            temperature: '30 C',
            rain: '30%',
            humidity: '58%',
            condition: 'Safe for outdoor work',
            workCondition: 'Carry water, afternoon heat likely',
          ),
          const SizedBox(height: 14),
          _MetricGrid(
            children: [
              DashboardMetric(
                label: 'Nearby jobs',
                value: jobsState.openJobsCount.toString(),
                icon: Icons.location_on_outlined,
              ),
              DashboardMetric(
                label: 'Today earning',
                value: 'Rs 0',
                icon: Icons.currency_rupee,
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SectionHeader(
            title: 'Nearby jobs',
            icon: Icons.work_outline,
            actionLabel: 'View all',
            onAction: () => context.go(AppRoutes.jobs),
          ),
          DashboardCard(
            title: 'Available jobs',
            subtitle: 'Browse local farm work and apply offline.',
            icon: Icons.work_outline,
            trailing: const Icon(Icons.chevron_right),
            voiceInstruction:
                'Open nearby jobs, read work details, and apply offline.',
            onTap: () => context.go(AppRoutes.jobs),
          ),
          const _PreviewList(
            title: 'Suggested farm jobs',
            items: [
              _PreviewItem(
                icon: Icons.priority_high_outlined,
                title: 'Cotton picking - 6 workers',
                subtitle: 'Rampur - 2 km',
                tag: 'Urgent',
              ),
              _PreviewItem(
                icon: Icons.verified_outlined,
                title: 'Irrigation help',
                subtitle: 'Kothapalli - 5 km',
                tag: 'Trusted Farmer',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _SectionHeader(
            title: 'Work readiness',
            icon: Icons.badge_outlined,
          ),
          DashboardCard(
            title: 'Availability',
            subtitle: profile?.isAvailable == true
                ? 'You are available for farm work.'
                : 'You are not marked available right now.',
            icon: Icons.event_available_outlined,
            onTap: () => context.push(AppRoutes.profileEdit),
          ),
          _SkillBadges(skills: profile?.skills ?? const []),
          const SizedBox(height: 18),
          const _NewsSection(
            title: 'Agriculture alerts',
            items: [
              _NewsItem('Weather', 'Light rain possible after 5 PM'),
              _NewsItem('Work tip', 'Carry gloves for cotton picking'),
              _NewsItem('Seasonal', 'Harvest work rising in nearby villages'),
            ],
          ),
          const SizedBox(height: 18),
          const _AiAssistantCard(
            title: 'Voice help',
            subtitle: 'Tap speaker buttons to hear simple guidance.',
            suggestion: 'Try: Find jobs near my village.',
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
        child: Row(
          children: [
            Icon(Icons.agriculture, color: scheme.onPrimaryContainer, size: 34),
            const SizedBox(width: 14),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: children,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          if (actionLabel != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard({
    required this.temperature,
    required this.rain,
    required this.humidity,
    required this.condition,
    required this.workCondition,
  });

  final String temperature;
  final String rain;
  final String humidity;
  final String condition;
  final String workCondition;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: scheme.tertiaryContainer,
                  foregroundColor: scheme.onTertiaryContainer,
                  child: const Icon(Icons.wb_sunny_outlined),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Weather and work condition',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(label: temperature, icon: Icons.thermostat),
                _InfoChip(label: 'Rain $rain', icon: Icons.water_drop_outlined),
                _InfoChip(label: 'Humidity $humidity', icon: Icons.opacity),
              ],
            ),
            const SizedBox(height: 12),
            Text(condition, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              workCondition,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertStrip extends StatelessWidget {
  const _AlertStrip({required this.items});

  final List<_ChipItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in items)
              _InfoChip(label: item.label, icon: item.icon),
          ],
        ),
      ),
    );
  }
}

class _PreviewList extends StatelessWidget {
  const _PreviewList({required this.title, required this.items});

  final String title;
  final List<_PreviewItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            for (final item in items)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(item.icon),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                trailing: Chip(
                  label: Text(item.tag),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ToolGrid extends StatelessWidget {
  const _ToolGrid({required this.title, required this.tools});

  final String title;
  final List<_ToolItem> tools;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.95,
              children: [
                for (final tool in tools)
                  _MiniToolCard(label: tool.label, icon: tool.icon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniToolCard extends StatelessWidget {
  const _MiniToolCard({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: scheme.primary),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsSection extends StatelessWidget {
  const _NewsSection({required this.title, required this.items});

  final String title;
  final List<_NewsItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            for (final item in items)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.campaign_outlined),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
              ),
          ],
        ),
      ),
    );
  }
}

class _AiAssistantCard extends StatelessWidget {
  const _AiAssistantCard({
    required this.title,
    required this.subtitle,
    required this.suggestion,
  });

  final String title;
  final String subtitle;
  final String suggestion;

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: title,
      subtitle: '$subtitle $suggestion',
      icon: Icons.auto_awesome_outlined,
      voiceInstruction: 'FarmMitra AI and voice help are placeholders for now.',
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'AI assistant placeholder. No backend connected yet.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }
}

class _SkillBadges extends StatelessWidget {
  const _SkillBadges({required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    final visibleSkills = skills.isEmpty
        ? const ['Harvesting', 'Sowing', 'Irrigation']
        : skills.take(5).toList(growable: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final skill in visibleSkills)
              _InfoChip(label: skill, icon: Icons.verified_outlined),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _ChipItem {
  const _ChipItem(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _PreviewItem {
  const _PreviewItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tag,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String tag;
}

class _ToolItem {
  const _ToolItem(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _NewsItem {
  const _NewsItem(this.title, this.subtitle);

  final String title;
  final String subtitle;
}
