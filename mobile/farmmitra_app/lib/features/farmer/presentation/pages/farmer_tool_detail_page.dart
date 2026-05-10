import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:flutter/material.dart';

class FarmerToolDetailPage extends StatelessWidget {
  const FarmerToolDetailPage({required this.toolId, super.key});

  final String toolId;

  @override
  Widget build(BuildContext context) {
    final tool = farmerToolItems.firstWhere(
      (item) => item.id == toolId,
      orElse: () => farmerToolItems.first,
    );

    return AppPageScaffold(
      title: tool.label,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(child: Icon(tool.icon)),
                  const SizedBox(height: 16),
                  Text(
                    tool.label,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This agriculture utility is a placeholder for the MVP. Offline calculations and backend intelligence can plug in later.',
                  ),
                  const SizedBox(height: 12),
                  const Chip(label: Text('Voice assistance coming soon')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
