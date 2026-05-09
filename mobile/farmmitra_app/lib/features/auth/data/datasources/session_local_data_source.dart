import 'package:drift/drift.dart';
import 'package:farmmitra_app/core/database/app_database.dart' as db;
import 'package:farmmitra_app/core/storage/secure_storage_service.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_method.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_session.dart'
    as domain;
import 'package:farmmitra_app/features/auth/domain/entities/local_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

final class SessionLocalDataSource {
  const SessionLocalDataSource({
    required db.AppDatabase database,
    required SecureStorageService secureStorage,
  }) : _database = database,
       _secureStorage = secureStorage;

  final db.AppDatabase _database;
  final SecureStorageService _secureStorage;

  Future<domain.AuthSession?> readActiveSession() async {
    final isLoggedIn = await _secureStorage.isLoggedIn();
    final localUserId = await _secureStorage.readActiveLocalUserId();
    final sessionId = await _secureStorage.readActiveSessionId();
    final accessToken = await _secureStorage.readAccessToken();
    final refreshToken = await _secureStorage.readRefreshToken();

    if (!isLoggedIn ||
        localUserId == null ||
        sessionId == null ||
        accessToken == null ||
        refreshToken == null) {
      return null;
    }

    final user = await (_database.select(
      _database.localUsers,
    )..where((table) => table.id.equals(localUserId))).getSingleOrNull();

    if (user == null) {
      await clearActiveSession();
      return null;
    }

    await (_database.update(_database.authSessions)
          ..where((table) => table.id.equals(sessionId)))
        .write(db.AuthSessionsCompanion(lastRestoredAt: Value(DateTime.now())));

    return domain.AuthSession(
      id: sessionId,
      localUserId: localUserId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      phoneNumber: user.phoneNumber,
      role: UserRole.fromStorageValue(user.role) ?? UserRole.farmer,
      method: AuthMethod.otp,
    );
  }

  Future<LocalAccount?> readLastAccount() async {
    final row =
        await (_database.select(_database.localUsers)
              ..orderBy([(table) => OrderingTerm.desc(table.lastLoginAt)])
              ..limit(1))
            .getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _mapUser(row);
  }

  Future<List<LocalAccount>> readAccounts() async {
    final rows = await (_database.select(
      _database.localUsers,
    )..orderBy([(table) => OrderingTerm.desc(table.lastLoginAt)])).get();

    return rows.map(_mapUser).toList(growable: false);
  }

  Future<void> saveActiveSession(domain.AuthSession session) async {
    final now = DateTime.now();

    await _database.transaction(() async {
      await _database
          .into(_database.localUsers)
          .insertOnConflictUpdate(
            db.LocalUsersCompanion.insert(
              id: session.localUserId,
              phoneNumber: session.phoneNumber,
              role: session.role.name,
              createdAt: now,
              lastLoginAt: now,
            ),
          );

      await (_database.update(_database.authSessions)
            ..where((table) => table.localUserId.equals(session.localUserId)))
          .write(const db.AuthSessionsCompanion(isActive: Value(false)));

      await _database
          .into(_database.authSessions)
          .insertOnConflictUpdate(
            db.AuthSessionsCompanion.insert(
              id: session.id,
              localUserId: session.localUserId,
              phoneNumber: session.phoneNumber,
              role: session.role.name,
              createdAt: now,
              isActive: const Value(true),
            ),
          );
    });

    await _secureStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
      phoneNumber: session.phoneNumber,
      localUserId: session.localUserId,
      sessionId: session.id,
      role: session.role.name,
    );
  }

  Future<void> saveSelectedRole(UserRole role) {
    return _secureStorage.saveSelectedRole(role.name);
  }

  Future<UserRole?> readSelectedRole() async {
    final role = await _secureStorage.readSelectedRole();
    return UserRole.fromStorageValue(role);
  }

  Future<void> clearActiveSession() async {
    final sessionId = await _secureStorage.readActiveSessionId();
    if (sessionId != null) {
      await (_database.update(
        _database.authSessions,
      )..where((table) => table.id.equals(sessionId))).write(
        db.AuthSessionsCompanion(
          isActive: const Value(false),
          loggedOutAt: Value(DateTime.now()),
        ),
      );
    }

    await _secureStorage.clearTokens();
  }

  LocalAccount _mapUser(db.LocalUser row) {
    return LocalAccount(
      id: row.id,
      phoneNumber: row.phoneNumber,
      role: UserRole.fromStorageValue(row.role) ?? UserRole.farmer,
      createdAt: row.createdAt,
      lastLoginAt: row.lastLoginAt,
    );
  }
}
