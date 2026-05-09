import 'package:farmmitra_app/core/sync/queued_sync_request.dart';
import 'package:flutter/material.dart';

class SyncQueueSummaryCard extends StatelessWidget {
  const SyncQueueSummaryCard({
    required this.requests,
    required this.onRetry,
    super.key,
  });

  final List<QueuedSyncRequest> requests;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final jobs = _countWhere('/jobs/', excludeApplications: true);
    final applications = _countWhere('/applications');
    final profiles = _countWhere('/profiles/');
    final other = requests.length - jobs - applications - profiles;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.pending_actions_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Queued local actions',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: requests.isEmpty ? null : onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _QueueChip(
                  label: 'Jobs',
                  count: jobs,
                  icon: Icons.work_outline,
                ),
                _QueueChip(
                  label: 'Applications',
                  count: applications,
                  icon: Icons.fact_check_outlined,
                ),
                _QueueChip(
                  label: 'Profiles',
                  count: profiles,
                  icon: Icons.account_circle_outlined,
                ),
                if (other > 0)
                  _QueueChip(
                    label: 'Other',
                    count: other,
                    icon: Icons.more_horiz,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _countWhere(String endpointPart, {bool excludeApplications = false}) {
    return requests.where((request) {
      final endpoint = request.endpoint;
      if (!endpoint.contains(endpointPart)) {
        return false;
      }
      return !excludeApplications || !endpoint.contains('/applications');
    }).length;
  }
}

class _QueueChip extends StatelessWidget {
  const _QueueChip({
    required this.label,
    required this.count,
    required this.icon,
  });

  final String label;
  final int count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text('$label: $count'),
      visualDensity: VisualDensity.compact,
    );
  }
}
