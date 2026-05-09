import 'package:farmmitra_app/features/jobs/data/datasources/jobs_local_data_source.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/job_application.dart';
import 'package:farmmitra_app/features/jobs/domain/repositories/jobs_repository.dart';

final class LocalJobsRepository implements JobsRepository {
  const LocalJobsRepository(this._localDataSource);

  final JobsLocalDataSource _localDataSource;

  @override
  Future<List<FarmJob>> readJobs() => _localDataSource.readJobs();

  @override
  Future<List<FarmJob>> readFarmerJobs(String farmerLocalUserId) {
    return _localDataSource.readFarmerJobs(farmerLocalUserId);
  }

  @override
  Future<FarmJob?> readJob(String jobId) => _localDataSource.readJob(jobId);

  @override
  Future<void> saveJob(FarmJob job) => _localDataSource.saveJob(job);

  @override
  Future<void> updateJobStatus({
    required String jobId,
    required JobStatus status,
  }) {
    return _localDataSource.updateJobStatus(jobId: jobId, status: status);
  }

  @override
  Future<List<JobApplication>> readWorkerApplications(
    String workerLocalUserId,
  ) {
    return _localDataSource.readWorkerApplications(workerLocalUserId);
  }

  @override
  Future<List<JobApplication>> readFarmerApplications(
    String farmerLocalUserId,
  ) {
    return _localDataSource.readFarmerApplications(farmerLocalUserId);
  }

  @override
  Future<JobApplication?> readApplicationForJob({
    required String jobId,
    required String workerLocalUserId,
  }) {
    return _localDataSource.readApplicationForJob(
      jobId: jobId,
      workerLocalUserId: workerLocalUserId,
    );
  }

  @override
  Future<void> saveApplication(JobApplication application) {
    return _localDataSource.saveApplication(application);
  }

  @override
  Future<void> updateApplicationStatus({
    required String applicationId,
    required JobApplicationStatus status,
  }) {
    return _localDataSource.updateApplicationStatus(
      applicationId: applicationId,
      status: status,
    );
  }
}
