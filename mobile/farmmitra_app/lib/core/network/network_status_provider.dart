import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmmitra_app/core/network/network_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  final connectivity = ref.watch(connectivityProvider);

  return connectivity.onConnectivityChanged.map((results) {
    final isOffline =
        results.isEmpty ||
        results.every((result) => result == ConnectivityResult.none);

    return isOffline ? NetworkStatus.offline : NetworkStatus.online;
  });
});
