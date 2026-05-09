import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

final class MockGoogleAccount {
  const MockGoogleAccount({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.preferredRole,
  });

  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final UserRole preferredRole;
}
