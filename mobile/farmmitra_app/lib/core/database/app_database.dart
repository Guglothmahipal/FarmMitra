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

class Jobs extends Table {
  TextColumn get id => text()();
  TextColumn get farmerLocalUserId => text().references(LocalUsers, #id)();
  TextColumn get title => text()();
  TextColumn get category => text().withDefault(const Constant('General'))();
  TextColumn get description => text()();
  TextColumn get workType => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get wage => integer()();
  IntColumn get workersRequired => integer()();
  DateTimeColumn get workDate => dateTime()();
  TextColumn get location => text()();
  TextColumn get status => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  BoolColumn get needsSync => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class JobApplications extends Table {
  TextColumn get id => text()();
  TextColumn get jobId => text().references(Jobs, #id)();
  TextColumn get workerLocalUserId => text().references(LocalUsers, #id)();
  TextColumn get status => text()();
  TextColumn get message => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  BoolColumn get needsSync => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SavedJobs extends Table {
  TextColumn get id => text()();
  TextColumn get jobId => text().references(Jobs, #id)();
  TextColumn get workerLocalUserId => text().references(LocalUsers, #id)();
  BoolColumn get needsSync => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalNotifications extends Table {
  TextColumn get id => text()();
  TextColumn get localUserId => text().references(LocalUsers, #id)();
  TextColumn get type => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();

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
    Jobs,
    JobApplications,
    SavedJobs,
    LocalNotifications,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

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
        if (from < 4) {
          await migrator.createTable(jobs);
          await migrator.createTable(jobApplications);
          await migrator.createTable(savedJobs);
        }
        if (from < 5) {
          await migrator.addColumn(jobs, jobs.category);
          await migrator.addColumn(jobs, jobs.notes);
          await migrator.addColumn(jobs, jobs.syncStatus);
          await migrator.addColumn(jobApplications, jobApplications.message);
          await migrator.addColumn(jobApplications, jobApplications.syncStatus);
          await migrator.createTable(localNotifications);
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
