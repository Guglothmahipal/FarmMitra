import 'package:farmmitra_app/core/database/database_provider.dart';
import 'package:farmmitra_app/core/sync/queued_sync_request.dart';
import 'package:farmmitra_app/core/sync/sync_queue_local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncQueueLocalDataSourceProvider = Provider<SyncQueueLocalDataSource>((
  ref,
) {
  return SyncQueueLocalDataSource(ref.watch(appDatabaseProvider));
});

final pendingSyncQueueCountProvider = FutureProvider<int>((ref) {
  return ref.watch(syncQueueLocalDataSourceProvider).pendingCount();
});

final pendingSyncRequestsProvider = FutureProvider<List<QueuedSyncRequest>>((
  ref,
) {
  return ref.watch(syncQueueLocalDataSourceProvider).oldestPending();
});
