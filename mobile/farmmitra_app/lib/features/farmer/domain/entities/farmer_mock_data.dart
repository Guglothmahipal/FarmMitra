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

final class FarmerToolItem {
  const FarmerToolItem(this.id, this.label, this.icon);

  final String id;
  final String label;
  final IconData icon;
}
