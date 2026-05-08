import 'package:farmmitra_app/config/env/app_config.dart';
import 'package:farmmitra_app/core/network/network_status.dart';

final class ArchitectureStatus {
  const ArchitectureStatus({
    required this.flavor,
    required this.apiBaseUrl,
    required this.networkStatus,
    required this.pendingSyncItems,
    required this.localDatabaseReady,
  });

  final AppFlavor flavor;
  final String apiBaseUrl;
  final NetworkStatus networkStatus;
  final int pendingSyncItems;
  final bool localDatabaseReady;
}
