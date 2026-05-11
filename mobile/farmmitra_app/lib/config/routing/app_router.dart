import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/config/localization/language_controller.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/phone_login_page.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/role_selection_page.dart';
import 'package:farmmitra_app/features/auth/presentation/pages/splash_page.dart';
import 'package:farmmitra_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:farmmitra_app/features/farmer/presentation/pages/farmer_market_page.dart';
import 'package:farmmitra_app/features/farmer/presentation/pages/farmer_tool_detail_page.dart';
import 'package:farmmitra_app/features/farmer/presentation/pages/farmer_updates_page.dart';
import 'package:farmmitra_app/features/farmer/presentation/pages/farmer_worker_detail_page.dart';
import 'package:farmmitra_app/features/farmer/presentation/pages/farmer_workers_page.dart';
import 'package:farmmitra_app/features/jobs/presentation/pages/applications_page.dart';
import 'package:farmmitra_app/features/jobs/presentation/pages/job_detail_page.dart';
import 'package:farmmitra_app/features/jobs/presentation/pages/job_form_page.dart';
import 'package:farmmitra_app/features/jobs/presentation/pages/jobs_page.dart';
import 'package:farmmitra_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:farmmitra_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:farmmitra_app/features/profile/presentation/controllers/profile_state.dart';
import 'package:farmmitra_app/features/profile/presentation/pages/profile_dashboard_page.dart';
import 'package:farmmitra_app/features/profile/presentation/pages/profile_form_page.dart';
import 'package:farmmitra_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:farmmitra_app/features/settings/presentation/pages/language_selection_page.dart';
import 'package:farmmitra_app/features/settings/presentation/pages/settings_page.dart';
import 'package:farmmitra_app/features/settings/presentation/pages/simple_info_page.dart';
import 'package:farmmitra_app/features/sync_status/presentation/pages/sync_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _RouterRefreshNotifier();

  ref.listen(authControllerProvider, (_, _) => refreshNotifier.refresh());
  ref.listen(profileControllerProvider, (_, _) => refreshNotifier.refresh());
  ref.listen(languageControllerProvider, (_, _) => refreshNotifier.refresh());
  ref.listen(splashMinimumDelayProvider, (_, _) => refreshNotifier.refresh());
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final languageState = ref.read(languageControllerProvider);
      final splashDelay = ref.read(splashMinimumDelayProvider);
      final location = state.uri.path;

      if (!splashDelay.hasValue) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (authState.status == AuthStatus.checking || languageState.isChecking) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (!languageState.hasSelectedLanguage) {
        return location == AppRoutes.languageSelection
            ? null
            : AppRoutes.languageSelection;
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
        if (location == AppRoutes.roleSelection ||
            location == AppRoutes.phoneLogin) {
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

      if (_isFarmerOnlyRoute(location) &&
          authState.selectedRole?.name == 'worker') {
        return AppRoutes.jobs;
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
        path: AppRoutes.languageSelection,
        name: AppRouteNames.languageSelection,
        builder: (context, state) =>
            const LanguageSelectionPage(isInitialSelection: true),
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
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: AppRouteNames.profile,
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
      GoRoute(
        path: AppRoutes.jobs,
        name: AppRouteNames.jobs,
        builder: (context, state) => const JobsPage(),
      ),
      GoRoute(
        path: AppRoutes.jobCreate,
        name: AppRouteNames.jobCreate,
        builder: (context, state) => const JobFormPage(),
      ),
      GoRoute(
        path: '${AppRoutes.jobEdit}/:jobId',
        name: AppRouteNames.jobEdit,
        builder: (context, state) =>
            JobFormPage(jobId: state.pathParameters['jobId']),
      ),
      GoRoute(
        path: '${AppRoutes.jobDetails}/:jobId',
        name: AppRouteNames.jobDetails,
        builder: (context, state) =>
            JobDetailPage(jobId: state.pathParameters['jobId'] ?? ''),
      ),
      GoRoute(
        path: AppRoutes.farmerWorkers,
        name: AppRouteNames.farmerWorkers,
        builder: (context, state) => const FarmerWorkersPage(),
      ),
      GoRoute(
        path: '${AppRoutes.farmerWorkerDetails}/:workerId',
        name: AppRouteNames.farmerWorkerDetails,
        builder: (context, state) => FarmerWorkerDetailPage(
          workerId: state.pathParameters['workerId'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.farmerUpdates,
        name: AppRouteNames.farmerUpdates,
        builder: (context, state) => const FarmerUpdatesPage(),
      ),
      GoRoute(
        path: AppRoutes.farmerMarket,
        name: AppRouteNames.farmerMarket,
        builder: (context, state) => const FarmerMarketPage(),
      ),
      GoRoute(
        path: '${AppRoutes.farmerToolDetails}/:toolId',
        name: AppRouteNames.farmerToolDetails,
        builder: (context, state) =>
            FarmerToolDetailPage(toolId: state.pathParameters['toolId'] ?? ''),
      ),
      GoRoute(
        path: AppRoutes.applications,
        name: AppRouteNames.applications,
        builder: (context, state) => const ApplicationsPage(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: AppRouteNames.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.syncStatus,
        name: AppRouteNames.syncStatus,
        builder: (context, state) => const SyncStatusPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.language,
        name: AppRouteNames.language,
        builder: (context, state) => const LanguageSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.support,
        name: AppRouteNames.support,
        builder: (context, state) => const SimpleInfoPage(
          title: 'Contact Support',
          message: 'Support contact and issue reporting will appear here.',
          icon: Icons.support_agent,
        ),
      ),
      GoRoute(
        path: AppRoutes.faq,
        name: AppRouteNames.faq,
        builder: (context, state) => const SimpleInfoPage(
          title: 'FAQ',
          message: 'Common questions for farmers and workers will appear here.',
          icon: Icons.help_outline,
        ),
      ),
      GoRoute(
        path: AppRoutes.about,
        name: AppRouteNames.about,
        builder: (context, state) => const SimpleInfoPage(
          title: 'About KhetRojgar',
          message:
              'KhetRojgar connects farmers and rural workers with offline-first workflows.',
          icon: Icons.info_outline,
        ),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        name: AppRouteNames.privacy,
        builder: (context, state) => const SimpleInfoPage(
          title: 'Privacy Policy',
          message:
              'Privacy policy placeholder for local-first profile, job, and session data.',
          icon: Icons.privacy_tip_outlined,
        ),
      ),
      GoRoute(
        path: AppRoutes.deleteAccount,
        name: AppRouteNames.deleteAccount,
        builder: (context, state) => const SimpleInfoPage(
          title: 'Delete Account Request',
          message:
              'Account deletion request flow placeholder. Local data is not deleted automatically.',
          icon: Icons.delete_outline,
        ),
      ),
    ],
  );
});

final splashMinimumDelayProvider = FutureProvider<void>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 3));
});

const _authOnlyRoutes = {
  AppRoutes.splash,
  AppRoutes.onboarding,
  AppRoutes.languageSelection,
  AppRoutes.roleSelection,
  AppRoutes.phoneLogin,
  AppRoutes.otpVerify,
};

bool _isFarmerOnlyRoute(String location) {
  return location == AppRoutes.jobCreate ||
      location.startsWith('${AppRoutes.jobEdit}/') ||
      location == AppRoutes.farmerWorkers ||
      location.startsWith('${AppRoutes.farmerWorkerDetails}/') ||
      location == AppRoutes.farmerUpdates ||
      location == AppRoutes.farmerMarket ||
      location.startsWith('${AppRoutes.farmerToolDetails}/');
}

final class _RouterRefreshNotifier extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
