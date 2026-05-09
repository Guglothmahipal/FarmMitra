import 'package:farmmitra_app/features/jobs/domain/entities/farm_job.dart';
import 'package:farmmitra_app/shared/widgets/offline_sync_badge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobCard extends StatelessWidget {
  JobCard({required this.job, this.trailing, this.onTap, super.key});

  final FarmJob job;
  final Widget? trailing;
  final VoidCallback? onTap;
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Chip(
                    label: Text(job.status.label),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('${job.category} • ${job.workType}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  _JobMeta(icon: Icons.currency_rupee, text: '${job.wage}/day'),
                  _JobMeta(
                    icon: Icons.groups_outlined,
                    text: '${job.workersRequired} workers',
                  ),
                  _JobMeta(
                    icon: Icons.event,
                    text: _dateFormat.format(job.workDate),
                  ),
                  _JobMeta(
                    icon: Icons.location_on_outlined,
                    text: job.location,
                  ),
                ],
              ),
              if (job.needsSync) ...[
                const SizedBox(height: 8),
                OfflineSyncBadge(status: job.syncStatus),
              ],
              if (trailing != null) ...[const SizedBox(height: 12), trailing!],
            ],
          ),
        ),
      ),
    );
  }
}

class _JobMeta extends StatelessWidget {
  const _JobMeta({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
