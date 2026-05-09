import 'package:drift/drift.dart';
import 'package:farmmitra_app/core/database/app_database.dart' as db;
import 'package:farmmitra_app/core/sync/sync_status.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/local_notification.dart';

final class NotificationsLocalDataSource {
  const NotificationsLocalDataSource(this._database);

  final db.AppDatabase _database;

  Future<List<LocalNotificationItem>> readNotifications(
    String localUserId,
  ) async {
    final rows =
        await (_database.select(_database.localNotifications)
              ..where((table) => table.localUserId.equals(localUserId))
              ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
            .get();

    return rows.map(_map).toList(growable: false);
  }

  Future<void> saveNotification(LocalNotificationItem notification) async {
    await _database
        .into(_database.localNotifications)
        .insertOnConflictUpdate(
          db.LocalNotificationsCompanion.insert(
            id: notification.id,
            localUserId: notification.localUserId,
            type: notification.type,
            title: notification.title,
            body: notification.body,
            createdAt: notification.createdAt,
            isRead: Value(notification.isRead),
            syncStatus: Value(notification.syncStatus.name),
          ),
        );
  }

  LocalNotificationItem _map(db.LocalNotification row) {
    return LocalNotificationItem(
      id: row.id,
      localUserId: row.localUserId,
      type: row.type,
      title: row.title,
      body: row.body,
      isRead: row.isRead,
      syncStatus: SyncStatus.fromValue(row.syncStatus),
      createdAt: row.createdAt,
    );
  }
}
