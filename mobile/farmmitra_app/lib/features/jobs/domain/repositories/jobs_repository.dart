import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/features/jobs/domain/entities/job_application.dart';

abstract interface class JobsRepository {
  Future<List<FarmJob>> readJobs();

  Future<List<FarmJob>> readFarmerJobs(String farmerLocalUserId);

  Future<FarmJob?> readJob(String jobId);

  Future<void> saveJob(FarmJob job);

  Future<void> updateJobStatus({
    required String jobId,
    required JobStatus status,
  });

  Future<List<JobApplication>> readWorkerApplications(String workerLocalUserId);

  Future<List<JobApplication>> readFarmerApplications(String farmerLocalUserId);

  Future<JobApplication?> readApplicationForJob({
    required String jobId,
    required String workerLocalUserId,
  });

  Future<void> saveApplication(JobApplication application);

  Future<void> updateApplicationStatus({
    required String applicationId,
    required JobApplicationStatus status,
  });
}
