import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
import 'package:farmmitra_app/features/farmer/presentation/widgets/farmer_section_header.dart';
import 'package:flutter/material.dart';

class FarmerUpdatesPreviewSection extends StatelessWidget {
  const FarmerUpdatesPreviewSection({this.onViewUpdates, super.key});

  final VoidCallback? onViewUpdates;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FarmerSectionHeader(
          title: 'Farmer Updates',
          icon: Icons.campaign_outlined,
          actionLabel: 'All',
          onAction: onViewUpdates,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final update in farmerUpdates)
                  Chip(
                    avatar: Icon(update.icon, size: 16),
                    label: Text('${update.group}: ${update.title}'),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
