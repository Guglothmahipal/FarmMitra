import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
import 'package:farmmitra_app/features/farmer/domain/entities/farmer_worker_profile.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:flutter/material.dart';

class FarmerWorkerDetailPage extends StatelessWidget {
  const FarmerWorkerDetailPage({required this.workerId, super.key});

  final String workerId;

  @override
  Widget build(BuildContext context) {
    final worker = mockFarmerWorkers.firstWhere(
      (item) => item.id == workerId,
      orElse: () => mockFarmerWorkers.first,
    );

    return AppPageScaffold(
      title: 'Worker Profile',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _WorkerHeader(worker: worker),
          const SizedBox(height: 12),
          _TrustGrid(worker: worker),
          const SizedBox(height: 12),
          _SkillsCard(worker: worker),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showPlaceholder(context, 'Chat'),
                  icon: const Icon(Icons.chat_outlined),
                  label: const Text('Chat'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showPlaceholder(context, 'Call'),
                  icon: const Icon(Icons.call_outlined),
                  label: const Text('Call'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: () => _showPlaceholder(context, 'Hire Worker'),
            icon: const Icon(Icons.handshake_outlined),
            label: const Text('Hire Worker'),
          ),
        ],
      ),
    );
  }

  void _showPlaceholder(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action placeholder. Backend integration coming later.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _WorkerHeader extends StatelessWidget {
  const _WorkerHeader({required this.worker});

  final FarmerWorkerProfile worker;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 42,
              child: Icon(Icons.engineering, size: 42),
            ),
            const SizedBox(height: 12),
            Text(worker.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('${worker.village} - ${worker.distance}'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text(worker.isAvailable ? 'Available' : 'Busy')),
                if (worker.isVerified) const Chip(label: Text('Verified')),
                Chip(label: Text('Joined ${worker.joinedDate}')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrustGrid extends StatelessWidget {
  const _TrustGrid({required this.worker});

  final FarmerWorkerProfile worker;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.05,
      children: [
        _TrustTile(label: 'Jobs', value: worker.completedJobs.toString()),
        _TrustTile(label: 'Trust', value: '${worker.trustScore}%'),
        _TrustTile(label: 'Rating', value: worker.rating.toStringAsFixed(1)),
      ],
    );
  }
}

class _TrustTile extends StatelessWidget {
  const _TrustTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _SkillsCard extends StatelessWidget {
  const _SkillsCard({required this.worker});

  final FarmerWorkerProfile worker;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills and languages',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final skill in worker.skills)
                  Chip(
                    avatar: const Icon(Icons.handyman, size: 16),
                    label: Text(skill),
                  ),
                for (final language in worker.languages)
                  Chip(
                    avatar: const Icon(Icons.translate, size: 16),
                    label: Text(language),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
