import 'package:flutter/material.dart';

class FarmerPrimaryActionsSection extends StatelessWidget {
  const FarmerPrimaryActionsSection({
    required this.onFindWorkers,
    required this.onCreateJob,
    super.key,
  });

  final VoidCallback onFindWorkers;
  final VoidCallback onCreateJob;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            title: 'Find Workers',
            subtitle: 'Hire nearby labour',
            icon: Icons.groups_outlined,
            onTap: onFindWorkers,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            title: 'Create Job',
            subtitle: 'Post farm work',
            icon: Icons.add_task_outlined,
            onTap: onCreateJob,
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: scheme.primary, size: 34),
              const SizedBox(height: 14),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                subtitle,
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
