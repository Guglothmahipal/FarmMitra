import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
import 'package:farmmitra_app/features/farmer/presentation/widgets/farmer_section_header.dart';
import 'package:flutter/material.dart';

class NearbyVendorsSection extends StatelessWidget {
  const NearbyVendorsSection({this.onViewMarket, super.key});

  final VoidCallback? onViewMarket;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FarmerSectionHeader(
          title: 'Nearby Agriculture Shops',
          icon: Icons.storefront_outlined,
          actionLabel: 'Market',
          onAction: onViewMarket,
        ),
        for (final vendor in nearbyVendors.take(3)) ...[
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(vendor.icon)),
              title: Text(vendor.name),
              subtitle: Text('${vendor.category} - ${vendor.distance}'),
              trailing: Chip(
                label: Text(vendor.offer),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
