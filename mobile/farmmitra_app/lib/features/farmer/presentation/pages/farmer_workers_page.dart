import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
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
          const SizedBox(height: 14),
          Card(
            child: ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: const Text('Job tracking'),
              subtitle: const Text('Manage posted jobs and applicants.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(AppRoutes.jobs),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Nearby workers',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final worker in mockFarmerWorkers) ...[
            FarmerWorkerCard(
              worker: worker,
              onTap: () =>
                  context.push('${AppRoutes.farmerWorkerDetails}/${worker.id}'),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _WorkerFilters extends StatelessWidget {
  const _WorkerFilters();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search workers',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: '10 km',
                    decoration: const InputDecoration(labelText: 'Distance'),
                    items: const [
                      DropdownMenuItem(value: '5 km', child: Text('5 km')),
                      DropdownMenuItem(value: '10 km', child: Text('10 km')),
                      DropdownMenuItem(value: '25 km', child: Text('25 km')),
                    ],
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: 'Any skill',
                    decoration: const InputDecoration(labelText: 'Skill'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Any skill',
                        child: Text('Any skill'),
                      ),
                      DropdownMenuItem(
                        value: 'Harvesting',
                        child: Text('Harvesting'),
                      ),
                      DropdownMenuItem(
                        value: 'Tractor',
                        child: Text('Tractor'),
                      ),
                    ],
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Available and verified only'),
              value: true,
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
