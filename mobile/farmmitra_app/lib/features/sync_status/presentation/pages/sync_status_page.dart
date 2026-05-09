import 'package:farmmitra_app/core/sync/sync_providers.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncQueueCountProvider = FutureProvider<int>((ref) {
  return ref.watch(syncQueueLocalDataSourceProvider).pendingCount();
});

class SyncStatusPage extends ConsumerWidget {
  const SyncStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingCount = ref.watch(syncQueueCountProvider);

    return Scaffold(
      drawer: const AppNavigationDrawer(),
      appBar: AppBar(title: const Text('Offline Sync')),
      body: SafeArea(
        child: pendingCount.when(
          data: (count) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.cloud_upload_outlined),
                  title: const Text('Pending operations'),
                  subtitle: Text('$count local operation(s) waiting for sync.'),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.repeat),
                  title: Text('Retry preparation'),
                  subtitle: Text(
                    'Background retry hooks will process this queue later.',
                  ),
                ),
              ),
            ],
          ),
          error: (_, _) =>
              const Center(child: Text('Could not load sync queue.')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
