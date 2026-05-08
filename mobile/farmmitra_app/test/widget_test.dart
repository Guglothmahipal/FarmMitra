import 'package:farmmitra_app/app/farmmitra_app.dart';
import 'package:farmmitra_app/features/auth/domain/entities/auth_session.dart';
import 'package:farmmitra_app/features/auth/domain/entities/local_account.dart';
import 'package:farmmitra_app/features/auth/domain/entities/user_role.dart';
import 'package:farmmitra_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/profile/domain/entities/farmer_profile.dart';
import 'package:farmmitra_app/features/profile/domain/entities/profile_snapshot.dart';
import 'package:farmmitra_app/features/profile/domain/entities/worker_profile.dart';
import 'package:farmmitra_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows farmer dashboard after authenticated profile restore', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith(
            (ref) => _AuthenticatedAuthRepo(),
          ),
          profileRepositoryProvider.overrideWith((ref) => _ProfileRepo()),
        ],
        child: const FarmMitraApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('FarmMitra'), findsOneWidget);
    expect(find.text('Farm details'), findsOneWidget);
    expect(find.text('Future jobs'), findsOneWidget);
  });
}

final class _AuthenticatedAuthRepo implements AuthRepository {
  @override
  Future<bool> isOnboardingCompleted() async => true;

  @override
  Future<void> setOnboardingCompleted() async {}

  @override
  Future<UserRole?> readSelectedRole() async => UserRole.farmer;

  @override
  Future<void> saveSelectedRole(UserRole role) async {}

  @override
  Future<AuthSession?> readSession() async => const AuthSession(
    id: 'test-session',
    localUserId: 'test-user',
    accessToken: 'test-access',
    refreshToken: 'test-refresh',
    phoneNumber: '9999999999',
    role: UserRole.farmer,
  );

  @override
  Future<List<LocalAccount>> readAccounts() async => const [];

  @override
  Future<void> requestOtp(String phoneNumber) async {}

  @override
  Future<AuthSession> verifyOtp({
    required String phoneNumber,
    required String otp,
    required UserRole role,
  }) async {
    return AuthSession(
      id: 'test-session',
      localUserId: 'test-user',
      accessToken: 'test-access',
      refreshToken: 'test-refresh',
      phoneNumber: phoneNumber,
      role: role,
    );
  }

  @override
  Future<void> signOut() async {}
}

final class _ProfileRepo implements ProfileRepository {
  final _farmer = FarmerProfile(
    id: 'test-farmer',
    fullName: 'Test Farmer',
    phoneNumber: '9999999999',
    village: 'Test Village',
    district: 'Test District',
    stateName: 'Test State',
    farmType: 'Irrigated',
    landSize: 4,
    preferredCrops: const ['Wheat', 'Cotton'],
    needsSync: true,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  @override
  Future<ProfileSnapshot?> readProfile({
    required UserRole role,
    required String localUserId,
  }) async {
    return role == UserRole.farmer ? ProfileSnapshot.farmer(_farmer) : null;
  }

  @override
  Future<FarmerProfile?> readFarmerProfile(String localUserId) async => _farmer;

  @override
  Future<WorkerProfile?> readWorkerProfile(String localUserId) async => null;

  @override
  Future<void> saveFarmerProfile(FarmerProfile profile) async {}

  @override
  Future<void> saveWorkerProfile(WorkerProfile profile) async {}
}
