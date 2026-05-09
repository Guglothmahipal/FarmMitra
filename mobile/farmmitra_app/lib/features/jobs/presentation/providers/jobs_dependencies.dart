import 'package:farmmitra_app/core/database/database_provider.dart';
import 'package:farmmitra_app/core/sync/sync_providers.dart';
import 'package:farmmitra_app/features/jobs/data/datasources/jobs_local_data_source.dart';
import 'package:farmmitra_app/features/jobs/data/repositories/local_jobs_repository.dart';
import 'package:farmmitra_app/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobsLocalDataSourceProvider = Provider<JobsLocalDataSource>((ref) {
  return JobsLocalDataSource(ref.watch(appDatabaseProvider));
});

final jobsRepositoryProvider = Provider<JobsRepository>((ref) {
  return LocalJobsRepository(ref.watch(jobsLocalDataSourceProvider));
});

final jobsSyncQueueProvider = syncQueueLocalDataSourceProvider;
