import 'package:farmmitra_app/core/errors/app_exception.dart';
import 'package:farmmitra_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_session.dart';
import 'package:farmmitra_app/features/auth/domain/entities/local_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/domain/repositories/auth_repository.dart';

final class MockAuthRepository implements AuthRepository {
  const MockAuthRepository(this._localDataSource);

  final AuthLocalDataSource _localDataSource;

  @override
  Future<bool> isOnboardingCompleted() {
    return _localDataSource.isOnboardingCompleted();
  }

  @override
  Future<void> setOnboardingCompleted() {
    return _localDataSource.setOnboardingCompleted();
  }

  @override
  Future<UserRole?> readSelectedRole() {
    return _localDataSource.readSelectedRole();
  }

  @override
  Future<void> saveSelectedRole(UserRole role) {
    return _localDataSource.saveSelectedRole(role);
  }

  @override
  Future<AuthSession?> readSession() {
    return _localDataSource.readSession();
  }

  @override
  Future<List<LocalAccount>> readAccounts() {
    return _localDataSource.readAccounts();
  }

  @override
  Future<void> requestOtp(String phoneNumber) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (phoneNumber.length < 10) {
      throw const AppException(message: 'Enter a valid mobile number');
    }
  }

  @override
  Future<AuthSession> verifyOtp({
    required String phoneNumber,
    required String otp,
    required UserRole role,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (otp.length != 6) {
      throw const AppException(message: 'Enter the 6-digit OTP');
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final localUserId = 'local-${role.name}-$phoneNumber';
    final session = AuthSession(
      id: 'session-$localUserId-$timestamp',
      localUserId: localUserId,
      accessToken: 'mock-access-$phoneNumber-$timestamp',
      refreshToken: 'mock-refresh-$phoneNumber-$timestamp',
      phoneNumber: phoneNumber,
      role: role,
    );

    await _localDataSource.saveSession(session);
    return session;
  }

  @override
  Future<void> signOut() {
    return _localDataSource.clearSession();
  }
}
