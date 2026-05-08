import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

final class LocalAccount {
  const LocalAccount({
    required this.id,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.lastLoginAt,
  });

  final String id;
  final String phoneNumber;
  final UserRole role;
  final DateTime createdAt;
  final DateTime lastLoginAt;
}
