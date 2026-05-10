import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_navigation_drawer.dart';
import 'package:farmmitra_app/shared/widgets/sync_visibility_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppTab { home, jobs, notifications, profile, workers, updates, market }

class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    required this.title,
    required this.currentTab,
    required this.body,
    this.actions,
    this.floatingActionButton,
    super.key,
  });

  final String title;
  final AppTab currentTab;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authControllerProvider).selectedRole;
    final tabs = _tabsForRole(role);
    final currentIndex = tabs.indexWhere((tab) => tab.tab == currentTab);

    return Scaffold(
      drawer: const AppNavigationDrawer(),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: NavigationToolbar.kMiddleSpacing,
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: SyncVisibilityBanner(compact: true),
            ),
            Expanded(
              child: KeyedSubtree(
                key: PageStorageKey(currentTab.name),
                child: body,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex < 0 ? 0 : currentIndex,
        onDestinationSelected: (index) => context.go(tabs[index].route),
        destinations: [
          for (final item in tabs)
            NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: item.label,
            ),
        ],
      ),
    );
  }

  List<_TabItem> _tabsForRole(UserRole? role) {
    if (role == UserRole.worker) {
      return const [
        _TabItem(
          tab: AppTab.home,
          label: 'Home',
          route: AppRoutes.home,
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
        ),
        _TabItem(
          tab: AppTab.jobs,
          label: 'Nearby Jobs',
          route: AppRoutes.jobs,
          icon: Icons.work_outline,
          selectedIcon: Icons.work,
        ),
        _TabItem(
          tab: AppTab.notifications,
          label: 'Alerts',
          route: AppRoutes.notifications,
          icon: Icons.notifications_outlined,
          selectedIcon: Icons.notifications,
        ),
        _TabItem(
          tab: AppTab.profile,
          label: 'Profile',
          route: AppRoutes.profile,
          icon: Icons.account_circle_outlined,
          selectedIcon: Icons.account_circle,
        ),
      ];
    }

    return const [
      _TabItem(
        tab: AppTab.home,
        label: 'Home',
        route: AppRoutes.home,
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
      ),
      _TabItem(
        tab: AppTab.workers,
        label: 'Workers',
        route: AppRoutes.farmerWorkers,
        icon: Icons.groups_outlined,
        selectedIcon: Icons.groups,
      ),
      _TabItem(
        tab: AppTab.updates,
        label: 'Updates',
        route: AppRoutes.farmerUpdates,
        icon: Icons.campaign_outlined,
        selectedIcon: Icons.campaign,
      ),
      _TabItem(
        tab: AppTab.market,
        label: 'Market',
        route: AppRoutes.farmerMarket,
        icon: Icons.storefront_outlined,
        selectedIcon: Icons.storefront,
      ),
    ];
  }
}

final class _TabItem {
  const _TabItem({
    required this.tab,
    required this.label,
    required this.route,
    required this.icon,
    required this.selectedIcon,
  });

  final AppTab tab;
  final String label;
  final String route;
  final IconData icon;
  final IconData selectedIcon;
}
