import 'package:farmmitra_app/core/errors/app_exception.dart';
import 'package:farmmitra_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_method.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_session.dart';
import 'package:farmmitra_app/features/auth/domain/entities/local_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/mock_google_account.dart';
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
  Future<List<MockGoogleAccount>> readMockGoogleAccounts(UserRole role) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return [
      MockGoogleAccount(
        id: 'primary',
        name: role == UserRole.farmer ? 'Ravi Farmer' : 'Anita Worker',
        email: role == UserRole.farmer
            ? 'ravi.farmer@farmmitra.local'
            : 'anita.worker@farmmitra.local',
        phoneNumber: role == UserRole.farmer ? '9000000001' : '9000000011',
        preferredRole: role,
      ),
      MockGoogleAccount(
        id: 'secondary',
        name: role == UserRole.farmer ? 'Sita Farmer' : 'Mahesh Worker',
        email: role == UserRole.farmer
            ? 'sita.farmer@farmmitra.local'
            : 'mahesh.worker@farmmitra.local',
        phoneNumber: role == UserRole.farmer ? '9000000002' : '9000000012',
        preferredRole: role,
      ),
    ];
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
    final session = _buildSession(
      phoneNumber: phoneNumber,
      role: role,
      method: AuthMethod.otp,
      timestamp: timestamp,
    );

    await _localDataSource.saveSession(session);
    return session;
  }

  @override
  Future<AuthSession> signInWithGoogle({
    required MockGoogleAccount account,
    required UserRole role,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final session = _buildSession(
      phoneNumber: account.phoneNumber,
      role: role,
      method: AuthMethod.google,
      timestamp: timestamp,
      accountId: account.id,
    );
    await _localDataSource.saveSession(session);
    return session;
  }

  @override
  Future<AuthSession> switchAccount(LocalAccount account) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final session = _buildSession(
      phoneNumber: account.phoneNumber,
      role: account.role,
      method: AuthMethod.otp,
      timestamp: timestamp,
    );
    await _localDataSource.saveSession(session);
    return session;
  }

  @override
  Future<void> signOut() {
    return _localDataSource.clearSession();
  }

  AuthSession _buildSession({
    required String phoneNumber,
    required UserRole role,
    required AuthMethod method,
    required int timestamp,
    String? accountId,
  }) {
    final source = accountId == null ? phoneNumber : '$accountId-$phoneNumber';
    final localUserId = 'local-${role.name}-$source';
    return AuthSession(
      id: 'session-$localUserId-$timestamp',
      localUserId: localUserId,
      accessToken: 'mock-${method.name}-access-$phoneNumber-$timestamp',
      refreshToken: 'mock-${method.name}-refresh-$phoneNumber-$timestamp',
      phoneNumber: phoneNumber,
      role: role,
      method: method,
    );
  }
}
