import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/notifications/domain/entities/local_notification.dart';
import 'package:farmmitra_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:farmmitra_app/features/notifications/presentation/providers/notifications_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class NotificationsController
    extends Notifier<List<LocalNotificationItem>> {
  late final NotificationsRepository _repository;

  @override
  List<LocalNotificationItem> build() {
    _repository = ref.watch(notificationsRepositoryProvider);
    ref.listen(authControllerProvider, (_, _) => Future<void>.microtask(load));
    Future<void>.microtask(load);
    return const [];
  }

  Future<void> load() async {
    final localUserId = ref.read(authControllerProvider).localUserId;
    if (localUserId == null) {
      state = const [];
      return;
    }

    state = await _repository.readNotifications(localUserId);
  }
}
