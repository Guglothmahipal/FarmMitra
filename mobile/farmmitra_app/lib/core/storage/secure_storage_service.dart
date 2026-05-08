import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _accessTokenKey = 'auth.access_token';
  static const _refreshTokenKey = 'auth.refresh_token';
  static const _isLoggedInKey = 'auth.is_logged_in';
  static const _selectedRoleKey = 'auth.selected_role';
  static const _phoneNumberKey = 'auth.phone_number';
  static const _activeLocalUserIdKey = 'auth.active_local_user_id';
  static const _activeSessionIdKey = 'auth.active_session_id';
  static const _onboardingCompletedKey = 'onboarding.completed';

  final FlutterSecureStorage _storage;

  Future<String?> readAccessToken() {
    return _storage.read(key: _accessTokenKey);
  }

  Future<String?> readRefreshToken() {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _isLoggedInKey);
    return value == 'true';
  }

  Future<bool> isOnboardingCompleted() async {
    final value = await _storage.read(key: _onboardingCompletedKey);
    return value == 'true';
  }

  Future<void> setOnboardingCompleted(bool value) {
    return _storage.write(
      key: _onboardingCompletedKey,
      value: value.toString(),
    );
  }

  Future<String?> readSelectedRole() {
    return _storage.read(key: _selectedRoleKey);
  }

  Future<String?> readPhoneNumber() {
    return _storage.read(key: _phoneNumberKey);
  }

  Future<String?> readActiveLocalUserId() {
    return _storage.read(key: _activeLocalUserIdKey);
  }

  Future<String?> readActiveSessionId() {
    return _storage.read(key: _activeSessionIdKey);
  }

  Future<void> saveSelectedRole(String role) {
    return _storage.write(key: _selectedRoleKey, value: role);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String phoneNumber,
    required String localUserId,
    required String sessionId,
    required String role,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _phoneNumberKey, value: phoneNumber),
      _storage.write(key: _activeLocalUserIdKey, value: localUserId),
      _storage.write(key: _activeSessionIdKey, value: sessionId),
      _storage.write(key: _selectedRoleKey, value: role),
      _storage.write(key: _isLoggedInKey, value: 'true'),
    ]);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _phoneNumberKey),
      _storage.delete(key: _activeLocalUserIdKey),
      _storage.delete(key: _activeSessionIdKey),
      _storage.delete(key: _selectedRoleKey),
      _storage.write(key: _isLoggedInKey, value: 'false'),
    ]);
  }
}
