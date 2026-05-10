import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
import 'package:farmmitra_app/features/farmer/domain/entities/farmer_mock_data.dart';
import 'package:flutter/material.dart';

class FarmerMarketPage extends StatelessWidget {
  const FarmerMarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Market',
      currentTab: AppTab.market,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          const _CategoryStrip(),
          const SizedBox(height: 14),
          const _FeaturedVendorCard(),
          const SizedBox(height: 14),
          Text(
            'Nearby vendors',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final vendor in nearbyVendors) ...[
            _MarketCard(vendor: vendor),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _CategoryChip('Seeds'),
          _CategoryChip('Fertilizers'),
          _CategoryChip('Pesticides'),
          _CategoryChip('Tools'),
          _CategoryChip('Machinery'),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: label == 'Seeds',
        onSelected: (_) {},
      ),
    );
  }
}

class _FeaturedVendorCard extends StatelessWidget {
  const _FeaturedVendorCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              child: const Icon(Icons.storefront_outlined),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sri Seeds Center',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '2 km - Cotton seeds from Rs 860',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const Chip(label: Text('5% off')),
          ],
        ),
      ),
    );
  }
}

class _MarketCard extends StatelessWidget {
  const _MarketCard({required this.vendor});

  final FarmerVendorItem vendor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(vendor.icon)),
        title: Text(vendor.name),
        subtitle: Text('${vendor.category} - ${vendor.distance}'),
        trailing: Chip(
          label: Text(vendor.offer),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
