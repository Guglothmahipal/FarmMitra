import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmmitra_app/config/env/app_config.dart';
import 'package:farmmitra_app/core/network/network_status.dart';
import 'package:farmmitra_app/core/sync/sync_queue_local_data_source.dart';
import 'package:farmmitra_app/features/home/domain/entities/architecture_status.dart';
import 'package:farmmitra_app/features/home/domain/repositories/home_repository.dart';

final class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required AppConfig config,
    required Connectivity connectivity,
    required SyncQueueLocalDataSource syncQueueLocalDataSource,
  }) : _config = config,
       _connectivity = connectivity,
       _syncQueueLocalDataSource = syncQueueLocalDataSource;

  final AppConfig _config;
  final Connectivity _connectivity;
  final SyncQueueLocalDataSource _syncQueueLocalDataSource;

  @override
  Future<ArchitectureStatus> loadArchitectureStatus() async {
    final results = await _connectivity.checkConnectivity();
    final pendingSyncItems = await _syncQueueLocalDataSource.pendingCount();

    final isOffline =
        results.isEmpty ||
        results.every((result) => result == ConnectivityResult.none);

    return ArchitectureStatus(
      flavor: _config.flavor,
      apiBaseUrl: _config.apiBaseUrl,
      networkStatus: isOffline ? NetworkStatus.offline : NetworkStatus.online,
      pendingSyncItems: pendingSyncItems,
      localDatabaseReady: true,
    );
  }
}
