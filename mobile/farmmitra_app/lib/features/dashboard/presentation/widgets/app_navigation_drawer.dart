import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppNavigationDrawer extends ConsumerWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final profile = ref.watch(profileControllerProvider).profile;
    final role = authState.selectedRole;
    final name = profile?.displayName.isNotEmpty == true
        ? profile!.displayName
        : role?.label ?? AppConstants.appName;

    return NavigationDrawer(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  role == UserRole.worker
                      ? Icons.engineering
                      : Icons.agriculture,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      authState.phoneNumber ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        _DrawerTile(
          icon: Icons.dashboard_outlined,
          label: 'Dashboard',
          route: AppRoutes.home,
        ),
        _DrawerTile(
          icon: Icons.account_circle_outlined,
          label: 'My Profile',
          route: AppRoutes.profile,
        ),
        _DrawerTile(
          icon: role == UserRole.farmer
              ? Icons.assignment_outlined
              : Icons.work_outline,
          label: role == UserRole.farmer ? 'My Jobs' : 'Available Jobs',
          route: AppRoutes.jobs,
        ),
        _DrawerTile(
          icon: Icons.fact_check_outlined,
          label: role == UserRole.farmer ? 'Applicants' : 'Applications',
          route: AppRoutes.applications,
        ),
        _DrawerTile(
          icon: Icons.notifications_outlined,
          label: 'Notifications',
          route: AppRoutes.notifications,
        ),
        _DrawerTile(
          icon: Icons.cloud_sync_outlined,
          label: 'Offline Sync Status',
          route: AppRoutes.syncStatus,
        ),
        if (role == UserRole.worker)
          const _DisabledDrawerTile(
            icon: Icons.bookmark_border,
            label: 'Saved Jobs',
          ),
        _DrawerTile(
          icon: Icons.settings_outlined,
          label: 'Settings',
          route: AppRoutes.settings,
        ),
        _DrawerTile(
          icon: Icons.translate_outlined,
          label: 'Change Language',
          route: AppRoutes.language,
        ),
        _DrawerTile(
          icon: Icons.support_agent,
          label: 'Contact Support',
          route: AppRoutes.support,
        ),
        _DrawerTile(
          icon: Icons.help_outline,
          label: 'FAQ',
          route: AppRoutes.faq,
        ),
        _DrawerTile(
          icon: Icons.info_outline,
          label: 'About KhetRojgar',
          route: AppRoutes.about,
        ),
        _DrawerTile(
          icon: Icons.privacy_tip_outlined,
          label: 'Privacy Policy',
          route: AppRoutes.privacy,
        ),
        _DrawerTile(
          icon: Icons.delete_outline,
          label: 'Delete Account Request',
          route: AppRoutes.deleteAccount,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            Navigator.of(context).pop();
            ref.read(authControllerProvider.notifier).signOut();
          },
        ),
      ],
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
    );
  }
}

class _DisabledDrawerTile extends StatelessWidget {
  const _DisabledDrawerTile({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(enabled: false, leading: Icon(icon), title: Text(label));
  }
}
