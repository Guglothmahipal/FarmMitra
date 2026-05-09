import 'package:farmmitra_app/features/notifications/domain/entities/local_notification.dart';

abstract interface class NotificationsRepository {
  Future<List<LocalNotificationItem>> readNotifications(String localUserId);

  Future<void> saveNotification(LocalNotificationItem notification);
}
