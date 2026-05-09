import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/notification_permission_status.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/local_notification.dart';
import 'package:farmmitra_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsControllerProvider);
    final permission = ref.watch(notificationPermissionControllerProvider);
    final grouped = _groupNotifications(notifications);

    return AppScaffold(
      title: 'Notifications',
      currentTab: AppTab.notifications,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _PushPermissionCard(status: permission),
          const SizedBox(height: 12),
          const _ReminderSection(),
          const SizedBox(height: 12),
          if (notifications.isEmpty)
            const _EmptyNotificationsCard()
          else
            for (final entry in grouped.entries) ...[
              _CategoryHeader(category: entry.key),
              const SizedBox(height: 8),
              for (final notification in entry.value)
                _NotificationCard(notification: notification),
              const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }

  Map<_NotificationCategory, List<LocalNotificationItem>> _groupNotifications(
    List<LocalNotificationItem> notifications,
  ) {
    final grouped = <_NotificationCategory, List<LocalNotificationItem>>{};
    for (final notification in notifications) {
      final category = _NotificationCategory.fromType(notification.type);
      grouped.putIfAbsent(category, () => []).add(notification);
    }
    return grouped;
  }
}

class _PushPermissionCard extends ConsumerWidget {
  const _PushPermissionCard({required this.status});

  final NotificationPermissionStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: Icon(
          status == NotificationPermissionStatus.granted
              ? Icons.notifications_active_outlined
              : Icons.notifications_off_outlined,
        ),
        title: const Text('Push notifications'),
        subtitle: Text(
          status == NotificationPermissionStatus.granted
              ? 'Weather, labour, jobs, and sync alerts are enabled locally.'
              : 'Enable alerts foundation for future Firebase push messages.',
        ),
        trailing: status == NotificationPermissionStatus.granted
            ? const Chip(
                label: Text('Enabled'),
                visualDensity: VisualDensity.compact,
              )
            : TextButton(
                onPressed: status == NotificationPermissionStatus.checking
                    ? null
                    : () => ref
                          .read(
                            notificationPermissionControllerProvider.notifier,
                          )
                          .requestPermission(),
                child: const Text('Enable'),
              ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final LocalNotificationItem notification;

  @override
  Widget build(BuildContext context) {
    final category = _NotificationCategory.fromType(notification.type);

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(category.icon)),
        title: Text(notification.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.body),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                Chip(
                  avatar: Icon(category.icon, size: 16),
                  label: Text(category.label),
                  visualDensity: VisualDensity.compact,
                ),
                Chip(
                  avatar: const Icon(Icons.schedule, size: 16),
                  label: Text(_formatTimestamp(notification.createdAt)),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _ReminderSection extends StatelessWidget {
  const _ReminderSection();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryHeader(
              category: _NotificationCategory.reminder,
              dense: true,
            ),
            SizedBox(height: 8),
            _ReminderTile(
              icon: Icons.water_drop_outlined,
              title: 'Irrigation reminder',
              subtitle: 'Check field moisture this evening.',
            ),
            _ReminderTile(
              icon: Icons.agriculture,
              title: 'Harvest reminder',
              subtitle: 'Plan labour two days before harvest.',
            ),
            _ReminderTile(
              icon: Icons.groups_outlined,
              title: 'Labour shortage alert',
              subtitle: 'Nearby demand may rise this week.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Chip(
        label: Text('Local'),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

class _EmptyNotificationsCard extends StatelessWidget {
  const _EmptyNotificationsCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.notifications_outlined),
        title: Text('No live alerts yet'),
        subtitle: Text(
          'Weather, jobs, sync, applications, and labour alerts will appear here.',
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.category, this.dense = false});

  final _NotificationCategory category;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(category.icon, size: dense ? 18 : 20),
        const SizedBox(width: 8),
        Text(
          category.label,
          style: dense
              ? Theme.of(context).textTheme.titleSmall
              : Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

enum _NotificationCategory {
  weather('Weather', Icons.wb_sunny_outlined),
  jobs('Jobs', Icons.work_outline),
  sync('Sync', Icons.cloud_sync_outlined),
  applications('Applications', Icons.fact_check_outlined),
  labour('Labour alerts', Icons.groups_outlined),
  reminder('Local reminders', Icons.alarm_outlined);

  const _NotificationCategory(this.label, this.icon);

  final String label;
  final IconData icon;

  static _NotificationCategory fromType(String type) {
    if (type.contains('weather')) {
      return _NotificationCategory.weather;
    }
    if (type.contains('application') || type.contains('applied')) {
      return _NotificationCategory.applications;
    }
    if (type.contains('sync')) {
      return _NotificationCategory.sync;
    }
    if (type.contains('labour') || type.contains('worker')) {
      return _NotificationCategory.labour;
    }
    return _NotificationCategory.jobs;
  }
}
