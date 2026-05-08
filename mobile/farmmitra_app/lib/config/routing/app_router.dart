import 'package:flutter/foundation.dart';
import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/onboarding_page.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/phone_login_page.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/role_selection_page.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/splash_page.dart';
import 'package:farmmitra_app/features/profile/presentation/controllers/profile_state.dart';
import 'package:farmmitra_app/features/profile/presentation/pages/profile_dashboard_page.dart';
import 'package:farmmitra_app/features/profile/presentation/pages/profile_form_page.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _RouterRefreshNotifier();

  ref.listen(authControllerProvider, (_, _) => refreshNotifier.refresh());
  ref.listen(profileControllerProvider, (_, _) => refreshNotifier.refresh());
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final location = state.uri.path;

      if (authState.status == AuthStatus.checking) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (!authState.onboardingCompleted) {
        return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
      }

      if (authState.selectedRole == null) {
        return location == AppRoutes.roleSelection
            ? null
            : AppRoutes.roleSelection;
      }

      if (!authState.isAuthenticated) {
        if (location == AppRoutes.phoneLogin) {
          return null;
        }

        if (location == AppRoutes.otpVerify &&
            authState.pendingPhoneNumber != null) {
          return null;
        }

        return AppRoutes.phoneLogin;
      }

      final profileState = ref.read(profileControllerProvider);
      if (profileState.status == ProfileStatus.checking) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (!profileState.hasCompletedProfile) {
        return location == AppRoutes.profileSetup
            ? null
            : AppRoutes.profileSetup;
      }

      if (_authOnlyRoutes.contains(location)) {
        return AppRoutes.home;
      }

      if (location == AppRoutes.profileSetup) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: AppRouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.roleSelection,
        name: AppRouteNames.roleSelection,
        builder: (context, state) => const RoleSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.phoneLogin,
        name: AppRouteNames.phoneLogin,
        builder: (context, state) => const PhoneLoginPage(),
      ),
      GoRoute(
        path: AppRoutes.otpVerify,
        name: AppRouteNames.otpVerify,
        builder: (context, state) => const OtpVerificationPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRouteNames.home,
        builder: (context, state) => const ProfileDashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.profileSetup,
        name: AppRouteNames.profileSetup,
        builder: (context, state) => const ProfileFormPage(isEdit: false),
      ),
      GoRoute(
        path: AppRoutes.profileEdit,
        name: AppRouteNames.profileEdit,
        builder: (context, state) => const ProfileFormPage(isEdit: true),
      ),
    ],
  );
});

const _authOnlyRoutes = {
  AppRoutes.splash,
  AppRoutes.onboarding,
  AppRoutes.roleSelection,
  AppRoutes.phoneLogin,
  AppRoutes.otpVerify,
};

final class _RouterRefreshNotifier extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
