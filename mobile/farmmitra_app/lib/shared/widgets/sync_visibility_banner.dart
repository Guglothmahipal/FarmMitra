import 'package:farmmitra_app/core/network/network_status.dart';
import 'package:farmmitra_app/core/network/network_status_provider.dart';
import 'package:farmmitra_app/core/sync/sync_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncVisibilityBanner extends ConsumerWidget {
  const SyncVisibilityBanner({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus = ref
        .watch(networkStatusProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    final pendingCount = ref
        .watch(pendingSyncQueueCountProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    final isOffline = networkStatus == NetworkStatus.offline;
    final count = pendingCount ?? 0;

    final state = isOffline
        ? _BannerState.offline
        : count > 0
        ? _BannerState.syncing
        : _BannerState.synced;

    final data = switch (state) {
      _BannerState.offline => const _BannerData(
        icon: Icons.cloud_off_outlined,
        title: 'Offline mode',
        message: 'Changes are saved on this phone and will wait for internet.',
      ),
      _BannerState.syncing => _BannerData(
        icon: Icons.cloud_upload_outlined,
        title: 'Syncing prepared',
        message: '$count local action(s) waiting for backend sync.',
      ),
      _BannerState.synced => const _BannerData(
        icon: Icons.cloud_done_outlined,
        title: 'Local data ready',
        message: 'No pending local actions right now.',
      ),
    };

    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: switch (state) {
        _BannerState.offline => scheme.errorContainer,
        _BannerState.syncing => scheme.secondaryContainer,
        _BannerState.synced => scheme.primaryContainer,
      },
      child: Padding(
        padding: EdgeInsets.all(compact ? 10 : 12),
        child: Row(
          children: [
            Icon(
              data.icon,
              color: switch (state) {
                _BannerState.offline => scheme.onErrorContainer,
                _BannerState.syncing => scheme.onSecondaryContainer,
                _BannerState.synced => scheme.onPrimaryContainer,
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  if (!compact) ...[
                    const SizedBox(height: 2),
                    Text(
                      data.message,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _BannerState { offline, syncing, synced }

class _BannerData {
  const _BannerData({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;
}
