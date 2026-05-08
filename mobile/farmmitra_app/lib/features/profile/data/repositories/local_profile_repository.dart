import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/profile_snapshot.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';
import 'package:farmmitra_app/features/profile/domain/repositories/profile_repository.dart';

final class LocalProfileRepository implements ProfileRepository {
  const LocalProfileRepository(this._localDataSource);

  final ProfileLocalDataSource _localDataSource;

  @override
  Future<ProfileSnapshot?> readProfile({
    required UserRole role,
    required String localUserId,
  }) async {
    if (role == UserRole.farmer) {
      final profile = await readFarmerProfile(localUserId);
      return profile == null ? null : ProfileSnapshot.farmer(profile);
    }

    final profile = await readWorkerProfile(localUserId);
    return profile == null ? null : ProfileSnapshot.worker(profile);
  }

  @override
  Future<FarmerProfile?> readFarmerProfile(String localUserId) {
    return _localDataSource.readFarmerProfile(localUserId);
  }

  @override
  Future<WorkerProfile?> readWorkerProfile(String localUserId) {
    return _localDataSource.readWorkerProfile(localUserId);
  }

  @override
  Future<void> saveFarmerProfile(FarmerProfile profile) {
    return _localDataSource.saveFarmerProfile(profile);
  }

  @override
  Future<void> saveWorkerProfile(WorkerProfile profile) {
    return _localDataSource.saveWorkerProfile(profile);
  }
}
