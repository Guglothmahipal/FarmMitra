import 'package:farmmitra_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_dependencies.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:farmmitra_app/features/auth/domain/entities/mock_google_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:farmmitra_app/features/auth/presentation/controllers/auth_dependencies.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

final localAccountsProvider = FutureProvider((ref) {
  ref.watch(authControllerProvider);
  return ref.watch(authRepositoryProvider).readAccounts();
});

final mockGoogleAccountsProvider =
    FutureProvider.family<List<MockGoogleAccount>, UserRole>((ref, role) {
      return ref.watch(authRepositoryProvider).readMockGoogleAccounts(role);
    });
