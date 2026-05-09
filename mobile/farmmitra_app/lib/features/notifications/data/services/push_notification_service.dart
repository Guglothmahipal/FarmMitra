import 'package:farmmitra_app/core/storage/secure_storage_service.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/local_push_message.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/notification_permission_status.dart';

final class PushNotificationService {
  const PushNotificationService(this._secureStorage);

  final SecureStorageService _secureStorage;

  Future<NotificationPermissionStatus> readPermissionStatus() async {
    final value = await _secureStorage.readNotificationPermissionStatus();
    return NotificationPermissionStatus.fromValue(value);
  }

  Future<NotificationPermissionStatus> requestPermission() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    await _secureStorage.saveNotificationPermissionStatus(
      NotificationPermissionStatus.granted.name,
    );
    return NotificationPermissionStatus.granted;
  }

  Future<void> denyPermission() {
    return _secureStorage.saveNotificationPermissionStatus(
      NotificationPermissionStatus.denied.name,
    );
  }

  Future<void> prepareLocalPush(LocalPushMessage message) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }
}
