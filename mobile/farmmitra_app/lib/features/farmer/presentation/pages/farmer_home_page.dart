import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/farmer/presentation/sections/agriculture_categories_section.dart';
import 'package:farmmitra_app/features/farmer/presentation/sections/farmer_primary_actions_section.dart';
import 'package:farmmitra_app/features/farmer/presentation/sections/farmer_updates_preview_section.dart';
import 'package:farmmitra_app/features/farmer/presentation/sections/farmer_weather_hero_section.dart';
import 'package:farmmitra_app/features/farmer/presentation/sections/nearby_vendors_section.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FarmerHomePage extends ConsumerWidget {
  const FarmerHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmer = ref.watch(profileControllerProvider).profile?.farmer;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
      children: [
        FarmerWeatherHeroSection(
          areaName: farmer?.village ?? 'Rampur village',
          currentDate: '10 May 2026',
        ),
        const SizedBox(height: 18),
        FarmerPrimaryActionsSection(
          onFindWorkers: () => context.go(AppRoutes.farmerWorkers),
          onCreateJob: () => context.push(AppRoutes.jobCreate),
        ),
        const SizedBox(height: 22),
        const AgricultureCategoriesSection(),
        const SizedBox(height: 22),
        NearbyVendorsSection(
          onViewMarket: () => context.go(AppRoutes.farmerMarket),
        ),
        const SizedBox(height: 14),
        FarmerUpdatesPreviewSection(
          onViewUpdates: () => context.go(AppRoutes.farmerUpdates),
        ),
      ],
    );
  }
}
