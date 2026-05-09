import 'package:farmmitra_app/features/auth/domain/entities/auth_method.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

final class AuthSession {
  const AuthSession({
    required this.id,
    required this.localUserId,
    required this.accessToken,
    required this.refreshToken,
    required this.phoneNumber,
    required this.role,
    this.method = AuthMethod.otp,
  });

  final String id;
  final String localUserId;
  final String accessToken;
  final String refreshToken;
  final String phoneNumber;
  final UserRole role;
  final AuthMethod method;
}
