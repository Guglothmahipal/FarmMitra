import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
import 'package:farmmitra_app/features/farmer/presentation/components/farmer_filter_chip.dart';
import 'package:farmmitra_app/features/farmer/presentation/widgets/farmer_worker_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FarmerWorkersPage extends StatelessWidget {
  const FarmerWorkersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Workers',
      currentTab: AppTab.workers,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          const _WorkerFilters(),
          const SizedBox(height: 18),
          Text(
            'Nearby workers',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final worker in mockFarmerWorkers) ...[
            FarmerWorkerCard(
              worker: worker,
              onViewProfile: () =>
                  context.push('${AppRoutes.farmerWorkerDetails}/${worker.id}'),
            ),
            const SizedBox(height: 12),
          ],
          Card(
            child: ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: const Text('Manage posted jobs'),
              subtitle: const Text('Open job tracking and applicants.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(AppRoutes.jobs),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkerFilters extends StatelessWidget {
  const _WorkerFilters();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Search workers',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FarmerFilterChip(
              label: 'Nearby',
              icon: Icons.location_on_outlined,
              selected: true,
            ),
            FarmerFilterChip(label: 'Verified', icon: Icons.verified_outlined),
            FarmerFilterChip(
              label: 'Available Today',
              icon: Icons.event_available_outlined,
            ),
            FarmerFilterChip(label: 'Harvesting', icon: Icons.grass_outlined),
            FarmerFilterChip(label: 'Irrigation', icon: Icons.water_outlined),
            FarmerFilterChip(label: 'Tractor', icon: Icons.agriculture),
            FarmerFilterChip(label: 'Experienced', icon: Icons.star_outline),
          ],
        ),
      ],
    );
  }
}
