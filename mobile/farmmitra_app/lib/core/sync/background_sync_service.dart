import 'package:workmanager/workmanager.dart';

final class BackgroundSyncService {
  const BackgroundSyncService._();

  static const syncQueuedRequestsTask = 'syncQueuedRequestsTask';

  static Future<void> registerPeriodicSync() {
    return Workmanager().registerPeriodicTask(
      syncQueuedRequestsTask,
      syncQueuedRequestsTask,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }
}
