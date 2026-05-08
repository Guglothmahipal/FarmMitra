import 'package:farmmitra_app/core/database/database_provider.dart';
import 'package:farmmitra_app/core/sync/sync_providers.dart';
import 'package:farmmitra_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:farmmitra_app/features/profile/data/repositories/local_profile_repository.dart';
import 'package:farmmitra_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  return ProfileLocalDataSource(ref.watch(appDatabaseProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return LocalProfileRepository(ref.watch(profileLocalDataSourceProvider));
});

final profileSyncQueueProvider = syncQueueLocalDataSourceProvider;
