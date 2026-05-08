import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';

final class ProfileSnapshot {
  const ProfileSnapshot.farmer(this.farmer)
    : worker = null,
      role = UserRole.farmer;

  const ProfileSnapshot.worker(this.worker)
    : farmer = null,
      role = UserRole.worker;

  final UserRole role;
  final FarmerProfile? farmer;
  final WorkerProfile? worker;

  String get displayName => switch (role) {
    UserRole.farmer => farmer?.fullName ?? '',
    UserRole.worker => worker?.fullName ?? '',
  };

  bool get needsSync => switch (role) {
    UserRole.farmer => farmer?.needsSync ?? false,
    UserRole.worker => worker?.needsSync ?? false,
  };
}
