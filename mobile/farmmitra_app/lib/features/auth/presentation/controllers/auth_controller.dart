import 'package:farmmitra_app/core/errors/app_exception.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_dependencies.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AuthController extends Notifier<AuthState> {
  late final AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    Future<void>.microtask(_restoreSession);
    return const AuthState.checking();
  }

  Future<void> _restoreSession() async {
    final onboardingCompleted = await _repository.isOnboardingCompleted();
    final selectedRole = await _repository.readSelectedRole();
    final session = await _repository.readSession();

    state = state.copyWith(
      status: session == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated,
      onboardingCompleted: onboardingCompleted,
      selectedRole: session?.role ?? selectedRole,
      localUserId: session?.localUserId,
      sessionId: session?.id,
      phoneNumber: session?.phoneNumber,
      clearActiveSession: session == null,
      clearError: true,
    );
  }

  Future<void> completeOnboarding() async {
    await _repository.setOnboardingCompleted();
    state = state.copyWith(onboardingCompleted: true, clearError: true);
  }

  Future<void> selectRole(UserRole role) async {
    await _repository.saveSelectedRole(role);
    state = state.copyWith(selectedRole: role, clearError: true);
  }

  Future<bool> requestOtp(String phoneNumber) async {
    final normalizedPhone = _normalizePhoneNumber(phoneNumber);
    state = state.copyWith(isSubmitting: true, clearError: true);

    try {
      await _repository.requestOtp(normalizedPhone);
      state = state.copyWith(
        isSubmitting: false,
        pendingPhoneNumber: normalizedPhone,
        clearError: true,
      );
      return true;
    } on AppException catch (error) {
      state = state.copyWith(isSubmitting: false, errorMessage: error.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Could not send OTP. Please try again.',
      );
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    final phoneNumber = state.pendingPhoneNumber;
    final role = state.selectedRole;

    if (phoneNumber == null || role == null) {
      state = state.copyWith(
        errorMessage: 'Please select your role and mobile number again.',
      );
      return false;
    }

    state = state.copyWith(isSubmitting: true, clearError: true);

    try {
      final session = await _repository.verifyOtp(
        phoneNumber: phoneNumber,
        otp: otp.trim(),
        role: role,
      );

      state = state.copyWith(
        status: AuthStatus.authenticated,
        selectedRole: session.role,
        localUserId: session.localUserId,
        sessionId: session.id,
        phoneNumber: session.phoneNumber,
        isSubmitting: false,
        clearPendingPhoneNumber: true,
        clearError: true,
      );
      return true;
    } on AppException catch (error) {
      state = state.copyWith(isSubmitting: false, errorMessage: error.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Could not verify OTP. Please try again.',
      );
      return false;
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      clearPendingPhoneNumber: true,
      clearSelectedRole: true,
      clearActiveSession: true,
      clearError: true,
    );
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  String _normalizePhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
