import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:farmmitra_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:farmmitra_app/shared/widgets/app_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsControllerProvider);

    return AppScaffold(
      title: 'Notifications',
      currentTab: AppTab.notifications,
      body: notifications.isEmpty
          ? const AppEmptyState(
              icon: Icons.notifications_outlined,
              title: 'No notifications',
              message: 'Job and sync updates will appear here.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: Text(notification.title),
                    subtitle: Text(notification.body),
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemCount: notifications.length,
            ),
    );
  }
}
