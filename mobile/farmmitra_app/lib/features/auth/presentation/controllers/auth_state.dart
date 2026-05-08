import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';

enum AuthStatus { checking, unauthenticated, authenticated }

final class AuthState {
  const AuthState({
    required this.status,
    required this.onboardingCompleted,
    required this.isSubmitting,
    this.selectedRole,
    this.localUserId,
    this.sessionId,
    this.phoneNumber,
    this.pendingPhoneNumber,
    this.errorMessage,
  });

  const AuthState.checking()
    : status = AuthStatus.checking,
      onboardingCompleted = false,
      selectedRole = null,
      localUserId = null,
      sessionId = null,
      phoneNumber = null,
      pendingPhoneNumber = null,
      isSubmitting = false,
      errorMessage = null;

  final AuthStatus status;
  final bool onboardingCompleted;
  final UserRole? selectedRole;
  final String? localUserId;
  final String? sessionId;
  final String? phoneNumber;
  final String? pendingPhoneNumber;
  final bool isSubmitting;
  final String? errorMessage;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    bool? onboardingCompleted,
    UserRole? selectedRole,
    String? localUserId,
    String? sessionId,
    String? phoneNumber,
    String? pendingPhoneNumber,
    bool? isSubmitting,
    String? errorMessage,
    bool clearPendingPhoneNumber = false,
    bool clearSelectedRole = false,
    bool clearActiveSession = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      selectedRole: clearSelectedRole
          ? null
          : selectedRole ?? this.selectedRole,
      localUserId: clearActiveSession ? null : localUserId ?? this.localUserId,
      sessionId: clearActiveSession ? null : sessionId ?? this.sessionId,
      phoneNumber: clearActiveSession ? null : phoneNumber ?? this.phoneNumber,
      pendingPhoneNumber: clearPendingPhoneNumber
          ? null
          : pendingPhoneNumber ?? this.pendingPhoneNumber,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
