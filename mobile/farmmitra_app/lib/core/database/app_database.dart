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

class LocalUsers extends Table {
  TextColumn get id => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get role => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastLoginAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AuthSessions extends Table {
  TextColumn get id => text()();
  TextColumn get localUserId => text().references(LocalUsers, #id)();
  TextColumn get phoneNumber => text()();
  TextColumn get role => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastRestoredAt => dateTime().nullable()();
  DateTimeColumn get loggedOutAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class FarmerProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get fullName => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get village => text()();
  TextColumn get district => text()();
  TextColumn get stateName => text()();
  TextColumn get farmType => text()();
  RealColumn get landSize => real()();
  TextColumn get preferredCropsJson => text()();
  TextColumn get photoPath => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get needsSync => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WorkerProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get fullName => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get village => text()();
  TextColumn get district => text()();
  TextColumn get stateName => text()();
  TextColumn get skillsJson => text()();
  IntColumn get yearsOfExperience => integer()();
  IntColumn get dailyWageExpectation => integer()();
  BoolColumn get isAvailable => boolean()();
  TextColumn get photoPath => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get needsSync => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    SyncQueueItems,
    CachedJobSummaries,
    LocalUsers,
    AuthSessions,
    FarmerProfiles,
    WorkerProfiles,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) => migrator.createAll(),
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.createTable(farmerProfiles);
          await migrator.createTable(workerProfiles);
        }
        if (from < 3) {
          await migrator.createTable(localUsers);
          await migrator.createTable(authSessions);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'farmmitra.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
