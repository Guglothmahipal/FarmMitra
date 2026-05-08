import 'package:farmmitra_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_dependencies.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:farmmitra_app/features/auth/presentation/controllers/auth_dependencies.dart';

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

final localAccountsProvider = FutureProvider((ref) {
  ref.watch(authControllerProvider);
  return ref.watch(authRepositoryProvider).readAccounts();
});
