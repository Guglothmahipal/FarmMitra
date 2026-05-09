import 'package:farmmitra_app/features/notifications/domain/entities/notification_permission_status.dart';
import 'package:farmmitra_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class NotificationPermissionController
    extends Notifier<NotificationPermissionStatus> {
  @override
  NotificationPermissionStatus build() {
    Future<void>.microtask(_restore);
    return NotificationPermissionStatus.checking;
  }

  Future<void> _restore() async {
    state = await ref
        .read(pushNotificationServiceProvider)
        .readPermissionStatus();
  }

  Future<void> requestPermission() async {
    state = NotificationPermissionStatus.checking;
    state = await ref.read(pushNotificationServiceProvider).requestPermission();
  }

  Future<void> denyPermission() async {
    await ref.read(pushNotificationServiceProvider).denyPermission();
    state = NotificationPermissionStatus.denied;
  }
}
