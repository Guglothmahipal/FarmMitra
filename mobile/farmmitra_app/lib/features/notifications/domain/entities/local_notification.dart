import 'package:farmmitra_app/core/sync/sync_status.dart';

final class LocalNotificationItem {
  const LocalNotificationItem({
    required this.id,
    required this.localUserId,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.syncStatus,
    required this.createdAt,
  });

  final String id;
  final String localUserId;
  final String type;
  final String title;
  final String body;
  final bool isRead;
  final SyncStatus syncStatus;
  final DateTime createdAt;
}
