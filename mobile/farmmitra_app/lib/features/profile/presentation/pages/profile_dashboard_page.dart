import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/profile_snapshot.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';
import 'package:farmmitra_app/features/profile/presentation/controllers/profile_state.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_empty_state.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_section_card.dart';
import 'package:farmmitra_app/features/profile/presentation/widgets/profile_tag_wrap.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileDashboardPage extends ConsumerWidget {
  const ProfileDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            tooltip: 'Edit profile',
            onPressed: profileState.hasCompletedProfile
                ? () => context.go(AppRoutes.profileEdit)
                : null,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(child: _DashboardBody(profileState: profileState)),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.profileState});

  final ProfileState profileState;

  @override
  Widget build(BuildContext context) {
    if (profileState.status == ProfileStatus.checking) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = profileState.profile;
    if (profile == null) {
      return ProfileEmptyState(
        title: 'Complete your profile',
        message:
            'Add your local details once and FarmMitra can use them for jobs, matching, and future sync.',
        action: AppPrimaryButton(
          label: 'Set up profile',
          icon: Icons.account_circle_outlined,
          onPressed: () => context.go(AppRoutes.profileSetup),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ProfileHeader(profile: profile),
          const SizedBox(height: 12),
          if (profile.role == UserRole.farmer)
            _FarmerDashboard(profile: profile.farmer!)
          else
            _WorkerDashboard(profile: profile.worker!),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final ProfileSnapshot profile;

  @override
  Widget build(BuildContext context) {
    return switch (profile.role) {
      UserRole.farmer => ProfileHeader(
        name: profile.farmer!.fullName,
        role: profile.role,
        village: profile.farmer!.village,
        district: profile.farmer!.district,
        needsSync: profile.needsSync,
      ),
      UserRole.worker => ProfileHeader(
        name: profile.worker!.fullName,
        role: profile.role,
        village: profile.worker!.village,
        district: profile.worker!.district,
        needsSync: profile.needsSync,
      ),
    };
  }
}

class _FarmerDashboard extends StatelessWidget {
  const _FarmerDashboard({required this.profile});

  final FarmerProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileSectionCard(
          title: 'Farm details',
          icon: Icons.grass_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(label: 'Farm type', value: profile.farmType),
              _InfoRow(label: 'Land size', value: '${profile.landSize} acres'),
              const SizedBox(height: 8),
              Text(
                'Preferred crops',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              ProfileTagWrap(items: profile.preferredCrops),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const ProfileSectionCard(
          title: 'Future jobs',
          icon: Icons.assignment_outlined,
          child: Text('Job posting and labour scheduling will appear here.'),
        ),
        const SizedBox(height: 12),
        const ProfileSectionCard(
          title: 'Worker requests',
          icon: Icons.groups_outlined,
          child: Text('Nearby worker requests and matches will appear here.'),
        ),
      ],
    );
  }
}

class _WorkerDashboard extends StatelessWidget {
  const _WorkerDashboard({required this.profile});

  final WorkerProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileSectionCard(
          title: 'Availability',
          icon: Icons.event_available_outlined,
          child: Row(
            children: [
              Icon(
                profile.isAvailable ? Icons.check_circle : Icons.pause_circle,
                color: profile.isAvailable ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                profile.isAvailable
                    ? 'Available for work'
                    : 'Not available now',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ProfileSectionCard(
          title: 'Skills',
          icon: Icons.handyman_outlined,
          child: ProfileTagWrap(items: profile.skills),
        ),
        const SizedBox(height: 12),
        ProfileSectionCard(
          title: 'Work details',
          icon: Icons.currency_rupee,
          child: Column(
            children: [
              _InfoRow(
                label: 'Experience',
                value: '${profile.yearsOfExperience} years',
              ),
              _InfoRow(
                label: 'Expected wage',
                value: 'Rs ${profile.dailyWageExpectation} / day',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const ProfileSectionCard(
          title: 'Future jobs',
          icon: Icons.work_outline,
          child: Text('Nearby jobs and applications will appear here.'),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
