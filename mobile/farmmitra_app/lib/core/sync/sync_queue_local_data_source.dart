import 'package:drift/drift.dart';
import 'package:farmmitra_app/core/database/app_database.dart';
import 'package:farmmitra_app/core/sync/queued_sync_request.dart';

final class SyncQueueLocalDataSource {
  const SyncQueueLocalDataSource(this._database);

  final AppDatabase _database;

  Future<int> pendingCount() {
    final countExpression = _database.syncQueueItems.id.count();
    final query = _database.selectOnly(_database.syncQueueItems)
      ..addColumns([countExpression]);

    return query.map((row) => row.read(countExpression) ?? 0).getSingle();
  }

  Future<List<QueuedSyncRequest>> oldestPending({int limit = 25}) async {
    final rows =
        await (_database.select(_database.syncQueueItems)
              ..orderBy([
                (table) => OrderingTerm.asc(table.createdAt),
                (table) => OrderingTerm.asc(table.attemptCount),
              ])
              ..limit(limit))
            .get();

    return rows
        .map(
          (row) => QueuedSyncRequest(
            id: row.id,
            method: row.method,
            endpoint: row.endpoint,
            payload: row.payload,
            attemptCount: row.attemptCount,
            createdAt: row.createdAt,
            lastAttemptAt: row.lastAttemptAt,
          ),
        )
        .toList(growable: false);
  }

  Future<void> enqueue({
    required String id,
    required String method,
    required String endpoint,
    required String payload,
  }) {
    return _database
        .into(_database.syncQueueItems)
        .insert(
          SyncQueueItemsCompanion.insert(
            id: id,
            method: method,
            endpoint: endpoint,
            payload: payload,
            createdAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> markAttempted(String id) async {
    final row = await (_database.select(
      _database.syncQueueItems,
    )..where((table) => table.id.equals(id))).getSingleOrNull();

    if (row == null) {
      return;
    }

    await (_database.update(
      _database.syncQueueItems,
    )..where((table) => table.id.equals(id))).write(
      SyncQueueItemsCompanion(
        attemptCount: Value(row.attemptCount + 1),
        lastAttemptAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> delete(String id) {
    return (_database.delete(
      _database.syncQueueItems,
    )..where((table) => table.id.equals(id))).go();
  }
}
