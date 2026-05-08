import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class SyncQueueItems extends Table {
  TextColumn get id => text()();
  TextColumn get method => text()();
  TextColumn get endpoint => text()();
  TextColumn get payload => text()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CachedJobSummaries extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get village => text()();
  TextColumn get district => text()();
  IntColumn get wageInRupees => integer()();
  DateTimeColumn get workDate => dateTime()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [SyncQueueItems, CachedJobSummaries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'farmmitra.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
