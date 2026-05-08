import 'package:farmmitra_app/core/database/database_provider.dart';
import 'package:farmmitra_app/core/storage/secure_storage_provider.dart';
import 'package:farmmitra_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:farmmitra_app/features/auth/data/datasources/session_local_data_source.dart';
import 'package:farmmitra_app/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:farmmitra_app/features/auth/data/services/session_manager.dart';
import 'package:farmmitra_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionLocalDataSourceProvider = Provider<SessionLocalDataSource>((ref) {
  return SessionLocalDataSource(
    database: ref.watch(appDatabaseProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
});

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return SessionManager(ref.watch(sessionLocalDataSourceProvider));
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSource(
    secureStorage: ref.watch(secureStorageProvider),
    sessionManager: ref.watch(sessionManagerProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository(ref.watch(authLocalDataSourceProvider));
});
