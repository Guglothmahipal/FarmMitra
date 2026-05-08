import 'dart:convert';

import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/profile_snapshot.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';
import 'package:farmmitra_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:farmmitra_app/features/profile/presentation/controllers/profile_state.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_dependencies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class ProfileController extends Notifier<ProfileState> {
  late final ProfileRepository _repository;

  @override
  ProfileState build() {
    _repository = ref.watch(profileRepositoryProvider);
    ref.listen(authControllerProvider, (previous, next) {
      if (previous?.status != next.status ||
          previous?.selectedRole != next.selectedRole ||
          previous?.localUserId != next.localUserId ||
          previous?.phoneNumber != next.phoneNumber) {
        Future<void>.microtask(loadProfile);
      }
    });
    Future<void>.microtask(loadProfile);
    return const ProfileState.checking();
  }

  Future<void> loadProfile() async {
    final authState = ref.read(authControllerProvider);

    if (!authState.isAuthenticated ||
        authState.selectedRole == null ||
        authState.localUserId == null) {
      state = state.copyWith(
        status: ProfileStatus.missing,
        clearProfile: true,
        clearError: true,
      );
      return;
    }

    state = state.copyWith(status: ProfileStatus.checking, clearError: true);

    final profile = await _repository.readProfile(
      role: authState.selectedRole!,
      localUserId: authState.localUserId!,
    );
    state = profile == null
        ? state.copyWith(status: ProfileStatus.missing, clearProfile: true)
        : state.copyWith(status: ProfileStatus.ready, profile: profile);
  }

  Future<bool> saveFarmerProfile({
    required String fullName,
    required String phoneNumber,
    required String village,
    required String district,
    required String stateName,
    required String farmType,
    required double landSize,
    required List<String> preferredCrops,
  }) async {
    state = state.copyWith(isSaving: true, clearError: true);

    try {
      final existing = state.profile?.farmer;
      final localUserId = ref.read(authControllerProvider).localUserId;
      if (localUserId == null) {
        throw StateError('No active local user');
      }
      final now = DateTime.now();
      final profile = FarmerProfile(
        id: localUserId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        village: village,
        district: district,
        stateName: stateName,
        farmType: farmType,
        landSize: landSize,
        preferredCrops: preferredCrops,
        photoPath: existing?.photoPath,
        latitude: existing?.latitude,
        longitude: existing?.longitude,
        needsSync: true,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );

      await _repository.saveFarmerProfile(profile);
      await _enqueueProfileSync(UserRole.farmer);
      state = state.copyWith(
        status: ProfileStatus.ready,
        isSaving: false,
        profile: ProfileSnapshot.farmer(profile),
      );
      return true;
    } catch (_) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'Could not save farmer profile. Please try again.',
      );
      return false;
    }
  }

  Future<bool> saveWorkerProfile({
    required String fullName,
    required String phoneNumber,
    required String village,
    required String district,
    required String stateName,
    required List<String> skills,
    required int yearsOfExperience,
    required int dailyWageExpectation,
    required bool isAvailable,
  }) async {
    state = state.copyWith(isSaving: true, clearError: true);

    try {
      final existing = state.profile?.worker;
      final localUserId = ref.read(authControllerProvider).localUserId;
      if (localUserId == null) {
        throw StateError('No active local user');
      }
      final now = DateTime.now();
      final profile = WorkerProfile(
        id: localUserId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        village: village,
        district: district,
        stateName: stateName,
        skills: skills,
        yearsOfExperience: yearsOfExperience,
        dailyWageExpectation: dailyWageExpectation,
        isAvailable: isAvailable,
        photoPath: existing?.photoPath,
        latitude: existing?.latitude,
        longitude: existing?.longitude,
        needsSync: true,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );

      await _repository.saveWorkerProfile(profile);
      await _enqueueProfileSync(UserRole.worker);
      state = state.copyWith(
        status: ProfileStatus.ready,
        isSaving: false,
        profile: ProfileSnapshot.worker(profile),
      );
      return true;
    } catch (_) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'Could not save worker profile. Please try again.',
      );
      return false;
    }
  }

  Future<void> _enqueueProfileSync(UserRole role) {
    final syncQueue = ref.read(profileSyncQueueProvider);
    return syncQueue.enqueue(
      id: 'profile-${role.name}-${DateTime.now().millisecondsSinceEpoch}',
      method: 'PUT',
      endpoint: '/profiles/${role.name}',
      payload: jsonEncode({
        'type': 'profile_update',
        'role': role.name,
        'created_offline': true,
      }),
    );
  }
}
