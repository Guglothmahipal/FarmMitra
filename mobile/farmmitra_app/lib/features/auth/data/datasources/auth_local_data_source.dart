import 'package:farmmitra_app/core/storage/secure_storage_service.dart';
import 'package:farmmitra_app/features/auth/data/services/session_manager.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_session.dart';
import 'package:farmmitra_app/features/auth/domain/entities/local_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

final class AuthLocalDataSource {
  const AuthLocalDataSource({
    required SecureStorageService secureStorage,
    required SessionManager sessionManager,
  }) : _secureStorage = secureStorage,
       _sessionManager = sessionManager;

  final SecureStorageService _secureStorage;
  final SessionManager _sessionManager;

  Future<bool> isOnboardingCompleted() {
    return _secureStorage.isOnboardingCompleted();
  }

  Future<void> setOnboardingCompleted() {
    return _secureStorage.setOnboardingCompleted(true);
  }

  Future<UserRole?> readSelectedRole() async {
    return _sessionManager.readSelectedRole();
  }

  Future<void> saveSelectedRole(UserRole role) {
    return _sessionManager.rememberSelectedRole(role);
  }

  Future<AuthSession?> readSession() {
    return _sessionManager.restoreActiveSession();
  }

  Future<List<LocalAccount>> readAccounts() {
    return _sessionManager.readAccounts();
  }

  Future<void> saveSession(AuthSession session) {
    return _sessionManager.activateSession(session);
  }

  Future<void> clearSession() {
    return _sessionManager.clearActiveSession();
  }
}
