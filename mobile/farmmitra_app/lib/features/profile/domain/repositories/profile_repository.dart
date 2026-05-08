import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/profile_snapshot.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';

abstract interface class ProfileRepository {
  Future<ProfileSnapshot?> readProfile({
    required UserRole role,
    required String localUserId,
  });

  Future<FarmerProfile?> readFarmerProfile(String localUserId);

  Future<WorkerProfile?> readWorkerProfile(String localUserId);

  Future<void> saveFarmerProfile(FarmerProfile profile);

  Future<void> saveWorkerProfile(WorkerProfile profile);
}
