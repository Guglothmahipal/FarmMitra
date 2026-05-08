import 'package:farmmitra_app/config/env/app_config_provider.dart';
import 'package:farmmitra_app/core/network/network_status_provider.dart';
import 'package:farmmitra_app/core/sync/sync_providers.dart';
import 'package:farmmitra_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:farmmitra_app/features/home/domain/entities/architecture_status.dart';
import 'package:farmmitra_app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    config: ref.watch(appConfigProvider),
    connectivity: ref.watch(connectivityProvider),
    syncQueueLocalDataSource: ref.watch(syncQueueLocalDataSourceProvider),
  );
});

final architectureStatusProvider = FutureProvider<ArchitectureStatus>((ref) {
  return ref.watch(homeRepositoryProvider).loadArchitectureStatus();
});
