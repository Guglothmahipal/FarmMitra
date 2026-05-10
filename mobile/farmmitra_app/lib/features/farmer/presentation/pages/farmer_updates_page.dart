import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class FarmerUpdatesPage extends StatelessWidget {
  const FarmerUpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Updates',
      currentTab: AppTab.updates,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: const [
          _UpdateGroup(
            title: 'Mandi Prices',
            icon: Icons.currency_rupee,
            items: [
              _UpdateItem('Cotton', 'Rs 7,120/q', 'Nearby mandi'),
              _UpdateItem('Soybean', 'Rs 4,680/q', 'Stable today'),
            ],
          ),
          _UpdateGroup(
            title: 'Weather Alerts',
            icon: Icons.wb_sunny_outlined,
            items: [
              _UpdateItem('Rain warning', 'After 5 PM', 'Avoid spraying'),
              _UpdateItem('Humidity', '62%', 'Check leaves'),
            ],
          ),
          _UpdateGroup(
            title: 'Government Schemes',
            icon: Icons.account_balance_outlined,
            items: [
              _UpdateItem('Equipment support', 'Open', 'Check eligibility'),
              _UpdateItem('Irrigation subsidy', 'Reminder', 'Documents needed'),
            ],
          ),
          _UpdateGroup(
            title: 'Pest/Disease Alerts',
            icon: Icons.health_and_safety_outlined,
            items: [
              _UpdateItem('Cotton watch', 'Moderate', 'Inspect plants'),
              _UpdateItem('Paddy tip', 'Seasonal', 'Drain excess water'),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpdateGroup extends StatelessWidget {
  const _UpdateGroup({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<_UpdateItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 10),
            for (final item in items)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                trailing: Chip(
                  label: Text(item.tag),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _UpdateItem {
  const _UpdateItem(this.title, this.subtitle, this.tag);

  final String title;
  final String subtitle;
  final String tag;
}
