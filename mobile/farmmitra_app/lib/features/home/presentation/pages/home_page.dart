import 'package:farmmitra_app/config/theme/app_colors.dart';
import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:farmmitra_app/core/network/network_status.dart';
import 'package:farmmitra_app/features/home/domain/entities/architecture_status.dart';
import 'package:farmmitra_app/features/home/presentation/controllers/home_providers.dart';
import 'package:farmmitra_app/shared/widgets/async_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(architectureStatusProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(architectureStatusProvider.future),
          child: AsyncStateView(
            value: status,
            data: (data) => _HomeContent(status: data),
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.status});

  final ArchitectureStatus status;

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.sizeOf(context).width < 360 ? 12.0 : 16.0;

    return ListView(
      padding: EdgeInsets.all(spacing),
      children: [
        Text(
          'Architecture foundation',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'FarmMitra is ready for feature modules, offline sync, API integration, and rural-first mobile workflows..Done By Mahipal',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: spacing),
        _StatusTile(
          icon: Icons.cloud_queue,
          label: 'API environment',
          value: status.flavor.name,
          detail: status.apiBaseUrl,
        ),
        SizedBox(height: spacing),
        _StatusTile(
          icon: status.networkStatus == NetworkStatus.online
              ? Icons.wifi
              : Icons.wifi_off,
          label: 'Network',
          value: status.networkStatus.name,
          detail: 'Connectivity-aware requests are wired through Dio.',
        ),
        SizedBox(height: spacing),
        _StatusTile(
          icon: Icons.storage,
          label: 'Local database',
          value: status.localDatabaseReady ? 'ready' : 'unavailable',
          detail: 'Drift SQLite is configured for offline caching.',
        ),
        SizedBox(height: spacing),
        _StatusTile(
          icon: Icons.sync,
          label: 'Pending sync',
          value: status.pendingSyncItems.toString(),
          detail: 'Queued writes can be replayed when connectivity returns.',
        ),
        SizedBox(height: spacing),
        const _ModuleStrip(),
      ],
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.seed),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(value, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleStrip extends StatelessWidget {
  const _ModuleStrip();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        _ModuleChip(label: 'Farmers'),
        _ModuleChip(label: 'Workers'),
        _ModuleChip(label: 'Jobs'),
        _ModuleChip(label: 'Sync'),
        _ModuleChip(label: 'AI-ready'),
      ],
    );
  }
}

class _ModuleChip extends StatelessWidget {
  const _ModuleChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: const Icon(Icons.check_circle_outline, size: 18),
      visualDensity: VisualDensity.compact,
    );
  }
}
