import 'package:drift/drift.dart';
import 'package:farmmitra_app/core/database/app_database.dart' as db;
import 'package:farmmitra_app/core/sync/sync_status.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/job_application.dart'
    as domain;

final class JobsLocalDataSource {
  const JobsLocalDataSource(this._database);

  final db.AppDatabase _database;

  Future<List<FarmJob>> readJobs() async {
    final rows = await (_database.select(
      _database.jobs,
    )..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).get();

    return rows.map(_mapJob).toList(growable: false);
  }

  Future<List<FarmJob>> readFarmerJobs(String farmerLocalUserId) async {
    final rows =
        await (_database.select(_database.jobs)
              ..where(
                (table) => table.farmerLocalUserId.equals(farmerLocalUserId),
              )
              ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
            .get();

    return rows.map(_mapJob).toList(growable: false);
  }

  Future<FarmJob?> readJob(String jobId) async {
    final row = await (_database.select(
      _database.jobs,
    )..where((table) => table.id.equals(jobId))).getSingleOrNull();

    return row == null ? null : _mapJob(row);
  }

  Future<void> saveJob(FarmJob job) async {
    await _database
        .into(_database.jobs)
        .insertOnConflictUpdate(
          db.JobsCompanion.insert(
            id: job.id,
            farmerLocalUserId: job.farmerLocalUserId,
            title: job.title,
            category: Value(job.category),
            description: job.description,
            workType: job.workType,
            notes: Value(job.notes),
            wage: job.wage,
            workersRequired: job.workersRequired,
            workDate: job.workDate,
            location: job.location,
            status: job.status.name,
            syncStatus: Value(job.syncStatus.name),
            needsSync: Value(job.needsSync),
            createdAt: job.createdAt,
            updatedAt: job.updatedAt,
          ),
        );
  }

  Future<void> updateJobStatus({
    required String jobId,
    required JobStatus status,
  }) async {
    await (_database.update(
      _database.jobs,
    )..where((table) => table.id.equals(jobId))).write(
      db.JobsCompanion(
        status: Value(status.name),
        syncStatus: const Value('pending'),
        needsSync: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<List<domain.JobApplication>> readWorkerApplications(
    String workerLocalUserId,
  ) async {
    final rows =
        await (_database.select(_database.jobApplications)
              ..where(
                (table) => table.workerLocalUserId.equals(workerLocalUserId),
              )
              ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
            .get();

    return rows.map(_mapApplication).toList(growable: false);
  }

  Future<List<domain.JobApplication>> readFarmerApplications(
    String farmerLocalUserId,
  ) async {
    final farmerJobs = await readFarmerJobs(farmerLocalUserId);
    final jobIds = farmerJobs.map((job) => job.id).toSet();
    if (jobIds.isEmpty) {
      return const [];
    }

    final rows =
        await (_database.select(_database.jobApplications)
              ..where((table) => table.jobId.isIn(jobIds))
              ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
            .get();

    return rows.map(_mapApplication).toList(growable: false);
  }

  Future<domain.JobApplication?> readApplicationForJob({
    required String jobId,
    required String workerLocalUserId,
  }) async {
    final row =
        await (_database.select(_database.jobApplications)..where(
              (table) =>
                  table.jobId.equals(jobId) &
                  table.workerLocalUserId.equals(workerLocalUserId),
            ))
            .getSingleOrNull();

    return row == null ? null : _mapApplication(row);
  }

  Future<void> saveApplication(domain.JobApplication application) async {
    await _database
        .into(_database.jobApplications)
        .insertOnConflictUpdate(
          db.JobApplicationsCompanion.insert(
            id: application.id,
            jobId: application.jobId,
            workerLocalUserId: application.workerLocalUserId,
            status: application.status.name,
            message: Value(application.message),
            syncStatus: Value(application.syncStatus.name),
            needsSync: Value(application.needsSync),
            createdAt: application.createdAt,
            updatedAt: application.updatedAt,
          ),
        );
  }

  Future<void> updateApplicationStatus({
    required String applicationId,
    required domain.JobApplicationStatus status,
  }) async {
    await (_database.update(
      _database.jobApplications,
    )..where((table) => table.id.equals(applicationId))).write(
      db.JobApplicationsCompanion(
        status: Value(status.name),
        needsSync: const Value(true),
        syncStatus: const Value('pending'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  FarmJob _mapJob(db.Job row) {
    return FarmJob(
      id: row.id,
      farmerLocalUserId: row.farmerLocalUserId,
      title: row.title,
      category: row.category,
      description: row.description,
      workType: row.workType,
      notes: row.notes,
      wage: row.wage,
      workersRequired: row.workersRequired,
      workDate: row.workDate,
      location: row.location,
      status: JobStatus.fromValue(row.status),
      syncStatus: SyncStatus.fromValue(row.syncStatus),
      needsSync: row.needsSync,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  domain.JobApplication _mapApplication(db.JobApplication row) {
    return domain.JobApplication(
      id: row.id,
      jobId: row.jobId,
      workerLocalUserId: row.workerLocalUserId,
      status: domain.JobApplicationStatus.fromValue(row.status),
      message: row.message,
      syncStatus: SyncStatus.fromValue(row.syncStatus),
      needsSync: row.needsSync,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
