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
          _UpdateCard(
            icon: Icons.currency_rupee,
            category: 'Mandi price',
            title: 'Cotton price steady',
            subtitle: 'Nearby mandi: Rs 7,120 / quintal',
          ),
          _UpdateCard(
            icon: Icons.account_balance_outlined,
            category: 'Government scheme',
            title: 'Farm equipment support',
            subtitle: 'Subsidy reminder placeholder for eligible farmers.',
          ),
          _UpdateCard(
            icon: Icons.wb_sunny_outlined,
            category: 'Weather alert',
            title: 'Rain expected this evening',
            subtitle: 'Avoid pesticide spraying after 4 PM.',
          ),
          _UpdateCard(
            icon: Icons.eco_outlined,
            category: 'Seasonal tip',
            title: 'Harvest labour demand rising',
            subtitle: 'Book workers early for the coming week.',
          ),
        ],
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  const _UpdateCard({
    required this.icon,
    required this.category,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String category;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Chip(
          label: Text(category),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
