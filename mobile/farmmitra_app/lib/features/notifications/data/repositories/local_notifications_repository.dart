import 'package:farmmitra_app/features/notifications/data/datasources/notifications_local_data_source.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/local_notification.dart';
import 'package:farmmitra_app/features/notifications/domain/repositories/notifications_repository.dart';

final class LocalNotificationsRepository implements NotificationsRepository {
  const LocalNotificationsRepository(this._localDataSource);

  final NotificationsLocalDataSource _localDataSource;

  @override
  Future<List<LocalNotificationItem>> readNotifications(String localUserId) {
    return _localDataSource.readNotifications(localUserId);
  }

  @override
  Future<void> saveNotification(LocalNotificationItem notification) {
    return _localDataSource.saveNotification(notification);
  }
}
