import 'package:farmmitra_app/features/dashboard/presentation/widgets/app_scaffold.dart';
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
        children: const [
          _CategoryStrip(),
          SizedBox(height: 14),
          _MarketCard(
            icon: Icons.grass_outlined,
            name: 'Sri Seeds Center',
            category: 'Seeds',
            price: 'Cotton seeds from Rs 860',
            discount: '5% off',
            distance: 'Rampur - 2 km',
          ),
          _MarketCard(
            icon: Icons.science_outlined,
            name: 'GreenGrow Fertilizers',
            category: 'Fertilizers',
            price: 'DAP bag Rs 1,350',
            discount: 'Local deal',
            distance: 'Kothapalli - 4 km',
          ),
          _MarketCard(
            icon: Icons.agriculture,
            name: 'Tractor Rental Point',
            category: 'Tractor rentals',
            price: 'Rs 900 / hour',
            discount: 'Morning slots',
            distance: 'Chandapur - 6 km',
          ),
          _MarketCard(
            icon: Icons.water_drop_outlined,
            name: 'Irrigation Supplies',
            category: 'Irrigation',
            price: 'Drip kit from Rs 2,400',
            discount: 'Featured',
            distance: 'Mandal road - 5 km',
          ),
        ],
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            Chip(label: Text('Seeds')),
            Chip(label: Text('Fertilizers')),
            Chip(label: Text('Pesticides')),
            Chip(label: Text('Tools')),
            Chip(label: Text('Irrigation')),
          ],
        ),
      ),
    );
  }
}

class _MarketCard extends StatelessWidget {
  const _MarketCard({
    required this.icon,
    required this.name,
    required this.category,
    required this.price,
    required this.discount,
    required this.distance,
  });

  final IconData icon;
  final String name;
  final String category;
  final String price;
  final String discount;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(name),
        subtitle: Text('$category - $price\n$distance'),
        isThreeLine: true,
        trailing: Chip(
          label: Text(discount),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
