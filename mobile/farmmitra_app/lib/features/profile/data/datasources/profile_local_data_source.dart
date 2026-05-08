import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:farmmitra_app/core/database/app_database.dart' as db;
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart'
    as domain;
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart'
    as domain;

final class ProfileLocalDataSource {
  const ProfileLocalDataSource(this._database);

  final db.AppDatabase _database;

  Future<domain.FarmerProfile?> readFarmerProfile(String localUserId) async {
    final row = await (_database.select(
      _database.farmerProfiles,
    )..where((table) => table.id.equals(localUserId))).getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _mapFarmer(row);
  }

  Future<domain.WorkerProfile?> readWorkerProfile(String localUserId) async {
    final row = await (_database.select(
      _database.workerProfiles,
    )..where((table) => table.id.equals(localUserId))).getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _mapWorker(row);
  }

  Future<void> saveFarmerProfile(domain.FarmerProfile profile) async {
    await _database
        .into(_database.farmerProfiles)
        .insertOnConflictUpdate(
          db.FarmerProfilesCompanion.insert(
            id: profile.id,
            fullName: profile.fullName,
            phoneNumber: profile.phoneNumber,
            village: profile.village,
            district: profile.district,
            stateName: profile.stateName,
            farmType: profile.farmType,
            landSize: profile.landSize,
            preferredCropsJson: jsonEncode(profile.preferredCrops),
            createdAt: profile.createdAt,
            updatedAt: profile.updatedAt,
            photoPath: Value(profile.photoPath),
            latitude: Value(profile.latitude),
            longitude: Value(profile.longitude),
            needsSync: Value(profile.needsSync),
          ),
        );
  }

  Future<void> saveWorkerProfile(domain.WorkerProfile profile) async {
    await _database
        .into(_database.workerProfiles)
        .insertOnConflictUpdate(
          db.WorkerProfilesCompanion.insert(
            id: profile.id,
            fullName: profile.fullName,
            phoneNumber: profile.phoneNumber,
            village: profile.village,
            district: profile.district,
            stateName: profile.stateName,
            skillsJson: jsonEncode(profile.skills),
            yearsOfExperience: profile.yearsOfExperience,
            dailyWageExpectation: profile.dailyWageExpectation,
            isAvailable: profile.isAvailable,
            createdAt: profile.createdAt,
            updatedAt: profile.updatedAt,
            photoPath: Value(profile.photoPath),
            latitude: Value(profile.latitude),
            longitude: Value(profile.longitude),
            needsSync: Value(profile.needsSync),
          ),
        );
  }

  domain.FarmerProfile _mapFarmer(db.FarmerProfile row) {
    return domain.FarmerProfile(
      id: row.id,
      fullName: row.fullName,
      phoneNumber: row.phoneNumber,
      village: row.village,
      district: row.district,
      stateName: row.stateName,
      farmType: row.farmType,
      landSize: row.landSize,
      preferredCrops: _decodeStringList(row.preferredCropsJson),
      photoPath: row.photoPath,
      latitude: row.latitude,
      longitude: row.longitude,
      needsSync: row.needsSync,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  domain.WorkerProfile _mapWorker(db.WorkerProfile row) {
    return domain.WorkerProfile(
      id: row.id,
      fullName: row.fullName,
      phoneNumber: row.phoneNumber,
      village: row.village,
      district: row.district,
      stateName: row.stateName,
      skills: _decodeStringList(row.skillsJson),
      yearsOfExperience: row.yearsOfExperience,
      dailyWageExpectation: row.dailyWageExpectation,
      isAvailable: row.isAvailable,
      photoPath: row.photoPath,
      latitude: row.latitude,
      longitude: row.longitude,
      needsSync: row.needsSync,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  List<String> _decodeStringList(String value) {
    final decoded = jsonDecode(value);
    if (decoded is! List) {
      return const [];
    }

    return decoded.whereType<String>().toList(growable: false);
  }
}
