import 'package:farmmitra_app/features/farmer/domain/entities/farmer_worker_profile.dart';
import 'package:flutter/material.dart';

const mockFarmerWorkers = [
  FarmerWorkerProfile(
    id: 'ramesh',
    name: 'Ramesh Kumar',
    village: 'Rampur',
    distance: '2 km',
    primarySkill: 'Cotton harvesting',
    skills: ['Cotton', 'Harvesting', 'Sowing'],
    rating: 4.8,
    isVerified: true,
    isAvailable: true,
    experience: '8 years farm labour experience',
    joinedDate: 'Jan 2025',
    completedJobs: 42,
    trustScore: 92,
    languages: ['Telugu', 'Hindi'],
  ),
  FarmerWorkerProfile(
    id: 'lakshmi',
    name: 'Lakshmi Devi',
    village: 'Kothapalli',
    distance: '4 km',
    primarySkill: 'Sowing team lead',
    skills: ['Sowing', 'Weeding', 'Paddy'],
    rating: 4.7,
    isVerified: true,
    isAvailable: true,
    experience: '6 years seasonal field work',
    joinedDate: 'Feb 2025',
    completedJobs: 31,
    trustScore: 88,
    languages: ['Telugu'],
  ),
  FarmerWorkerProfile(
    id: 'mahesh',
    name: 'Mahesh Patil',
    village: 'Chandapur',
    distance: '6 km',
    primarySkill: 'Tractor driving',
    skills: ['Tractor', 'Irrigation', 'Harvesting'],
    rating: 4.5,
    isVerified: false,
    isAvailable: false,
    experience: 'Tractor and irrigation support',
    joinedDate: 'Mar 2025',
    completedJobs: 18,
    trustScore: 76,
    languages: ['Hindi', 'Marathi'],
  ),
];

const farmerToolItems = [
  FarmerToolItem('crop-planner', 'Crop planner', Icons.eco_outlined),
  FarmerToolItem(
    'irrigation-planner',
    'Irrigation planner',
    Icons.water_outlined,
  ),
  FarmerToolItem(
    'labour-calculator',
    'Labour calculator',
    Icons.calculate_outlined,
  ),
  FarmerToolItem(
    'harvest-planner',
    'Harvest planner',
    Icons.event_note_outlined,
  ),
  FarmerToolItem(
    'expense-tracker',
    'Expense tracker',
    Icons.receipt_long_outlined,
  ),
  FarmerToolItem(
    'weather-planning',
    'Weather planning',
    Icons.wb_sunny_outlined,
  ),
];

const farmerCategories = [
  FarmerCategoryItem('Tools', Icons.handyman_outlined),
  FarmerCategoryItem('Fertilizers', Icons.science_outlined),
  FarmerCategoryItem('Pesticides', Icons.health_and_safety_outlined),
  FarmerCategoryItem('Seeds', Icons.grass_outlined),
  FarmerCategoryItem('Machinery', Icons.agriculture),
  FarmerCategoryItem('Crop Care', Icons.eco_outlined),
  FarmerCategoryItem('Irrigation', Icons.water_drop_outlined),
];

const nearbyVendors = [
  FarmerVendorItem(
    name: 'Sri Seeds Center',
    category: 'Seeds',
    distance: '2 km',
    offer: 'Cotton seeds',
    icon: Icons.grass_outlined,
  ),
  FarmerVendorItem(
    name: 'GreenGrow Fertilizers',
    category: 'Fertilizers',
    distance: '4 km',
    offer: '5% local deal',
    icon: Icons.science_outlined,
  ),
  FarmerVendorItem(
    name: 'Tractor Rental Point',
    category: 'Machinery',
    distance: '6 km',
    offer: 'Morning slots',
    icon: Icons.agriculture,
  ),
  FarmerVendorItem(
    name: 'Irrigation Supplies',
    category: 'Irrigation',
    distance: '5 km',
    offer: 'Drip kits',
    icon: Icons.water_drop_outlined,
  ),
];

const farmerUpdates = [
  FarmerUpdateItem(
    group: 'Mandi',
    title: 'Cotton Rs 7,120/q',
    message: 'Nearby mandi price steady',
    icon: Icons.currency_rupee,
  ),
  FarmerUpdateItem(
    group: 'Weather',
    title: 'Rain after 5 PM',
    message: 'Avoid pesticide spraying',
    icon: Icons.wb_sunny_outlined,
  ),
  FarmerUpdateItem(
    group: 'Scheme',
    title: 'Equipment support',
    message: 'Subsidy reminder',
    icon: Icons.account_balance_outlined,
  ),
  FarmerUpdateItem(
    group: 'Crop',
    title: 'Humidity watch',
    message: 'Check cotton leaves',
    icon: Icons.eco_outlined,
  ),
];

final class FarmerToolItem {
  const FarmerToolItem(this.id, this.label, this.icon);

  final String id;
  final String label;
  final IconData icon;
}

final class FarmerCategoryItem {
  const FarmerCategoryItem(this.label, this.icon);

  final String label;
  final IconData icon;
}

final class FarmerVendorItem {
  const FarmerVendorItem({
    required this.name,
    required this.category,
    required this.distance,
    required this.offer,
    required this.icon,
  });

  final String name;
  final String category;
  final String distance;
  final String offer;
  final IconData icon;
}

final class FarmerUpdateItem {
  const FarmerUpdateItem({
    required this.group,
    required this.title,
    required this.message,
    required this.icon,
  });

  final String group;
  final String title;
  final String message;
  final IconData icon;
}
