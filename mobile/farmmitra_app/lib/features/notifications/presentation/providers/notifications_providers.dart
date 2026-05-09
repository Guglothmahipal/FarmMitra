import 'package:farmmitra_app/core/database/database_provider.dart';
import 'package:farmmitra_app/core/storage/secure_storage_provider.dart';
import 'package:farmmitra_app/features/notifications/data/datasources/notifications_local_data_source.dart';
import 'package:farmmitra_app/features/notifications/data/repositories/local_notifications_repository.dart';
import 'package:farmmitra_app/features/notifications/data/services/push_notification_service.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/local_notification.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/notification_permission_status.dart';
import 'package:farmmitra_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:farmmitra_app/features/notifications/presentation/controllers/notification_permission_controller.dart';
import 'package:farmmitra_app/features/notifications/presentation/controllers/notifications_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsLocalDataSourceProvider =
    Provider<NotificationsLocalDataSource>((ref) {
      return NotificationsLocalDataSource(ref.watch(appDatabaseProvider));
    });

final notificationsRepositoryProvider = Provider<NotificationsRepository>((
  ref,
) {
  return LocalNotificationsRepository(
    ref.watch(notificationsLocalDataSourceProvider),
  );
});

final pushNotificationServiceProvider = Provider<PushNotificationService>((
  ref,
) {
  return PushNotificationService(ref.watch(secureStorageProvider));
});

final notificationsControllerProvider =
    NotifierProvider<NotificationsController, List<LocalNotificationItem>>(
      NotificationsController.new,
    );

final notificationPermissionControllerProvider =
    NotifierProvider<
      NotificationPermissionController,
      NotificationPermissionStatus
    >(NotificationPermissionController.new);
