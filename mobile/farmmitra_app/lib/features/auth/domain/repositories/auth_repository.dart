import 'package:farmmitra_app/features/auth/domain/entities/auth_session.dart';
import 'package:farmmitra_app/features/auth/domain/entities/local_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

abstract interface class AuthRepository {
  Future<bool> isOnboardingCompleted();

  Future<void> setOnboardingCompleted();

  Future<UserRole?> readSelectedRole();

  Future<void> saveSelectedRole(UserRole role);

  Future<AuthSession?> readSession();

  Future<List<LocalAccount>> readAccounts();

  Future<void> requestOtp(String phoneNumber);

  Future<AuthSession> verifyOtp({
    required String phoneNumber,
    required String otp,
    required UserRole role,
  });

  Future<void> signOut();
}
