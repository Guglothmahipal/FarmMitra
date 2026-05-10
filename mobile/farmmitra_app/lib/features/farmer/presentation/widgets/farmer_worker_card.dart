import 'package:farmmitra_app/features/farmer/domain/entities/farmer_worker_profile.dart';
import 'package:flutter/material.dart';

class FarmerWorkerCard extends StatelessWidget {
  const FarmerWorkerCard({required this.worker, this.onTap, super.key});

  final FarmerWorkerProfile worker;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: scheme.primaryContainer,
                    foregroundColor: scheme.onPrimaryContainer,
                    child: const Icon(Icons.engineering),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          worker.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text('${worker.village} - ${worker.distance}'),
                      ],
                    ),
                  ),
                  Icon(Icons.star, size: 18, color: scheme.primary),
                  const SizedBox(width: 2),
                  Text(worker.rating.toStringAsFixed(1)),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _WorkerChip(
                    label: worker.isAvailable ? 'Available' : 'Busy',
                    icon: worker.isAvailable
                        ? Icons.check_circle_outline
                        : Icons.pause_circle_outline,
                  ),
                  if (worker.isVerified)
                    const _WorkerChip(
                      label: 'Verified',
                      icon: Icons.verified_user_outlined,
                    ),
                  _WorkerChip(label: worker.primarySkill, icon: Icons.handyman),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                worker.experience,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkerChip extends StatelessWidget {
  const _WorkerChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}
