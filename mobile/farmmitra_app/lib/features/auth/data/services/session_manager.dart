import 'package:farmmitra_app/features/auth/data/datasources/session_local_data_source.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_session.dart'
    as domain;
import 'package:farmmitra_app/features/auth/domain/entities/local_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

final class SessionManager {
  const SessionManager(this._localDataSource);

  final SessionLocalDataSource _localDataSource;

  Future<domain.AuthSession?> restoreActiveSession() {
    return _localDataSource.readActiveSession();
  }

  Future<void> activateSession(domain.AuthSession session) {
    return _localDataSource.saveActiveSession(session);
  }

  Future<void> clearActiveSession() {
    return _localDataSource.clearActiveSession();
  }

  Future<void> rememberSelectedRole(UserRole role) {
    return _localDataSource.saveSelectedRole(role);
  }

  Future<UserRole?> readSelectedRole() {
    return _localDataSource.readSelectedRole();
  }

  Future<List<LocalAccount>> readAccounts() {
    return _localDataSource.readAccounts();
  }
}
