import 'package:flutter/material.dart';

class FarmerWeatherHeroSection extends StatelessWidget {
  const FarmerWeatherHeroSection({
    required this.areaName,
    required this.currentDate,
    super.key,
  });

  final String areaName;
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                  child: const Icon(Icons.wb_sunny_outlined),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        areaName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: scheme.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        currentDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Voice assistance coming soon',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voice assistance coming soon.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.mic_none_outlined,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              '31 C',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Partly cloudy',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _WeatherPill(
                  icon: Icons.water_drop_outlined,
                  label: 'Rain 35%',
                ),
                _WeatherPill(icon: Icons.opacity, label: 'Humidity 62%'),
              ],
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.tips_and_updates_outlined),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Good day for harvesting. Avoid pesticide spraying this evening.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherPill extends StatelessWidget {
  const _WeatherPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}
