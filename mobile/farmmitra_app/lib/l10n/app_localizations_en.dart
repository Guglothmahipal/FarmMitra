// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'KhetRojgar';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonNext => 'Next';

  @override
  String get commonGetStarted => 'Get Started';

  @override
  String get commonSaving => 'Saving...';

  @override
  String get commonRequired => 'Required';

  @override
  String get languageChooseTitle => 'Choose Language';

  @override
  String get languageChangeTitle => 'Change Language';

  @override
  String get languageInitialPrompt =>
      'Select the language you read comfortably.';

  @override
  String get languageChangePrompt => 'Change your saved app language.';

  @override
  String get languageSaveButton => 'Save Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageTelugu => 'Telugu';

  @override
  String get roleHeroSubtitle => 'Choose your role to continue';

  @override
  String get roleQuestion => 'How will you use KhetRojgar?';

  @override
  String get roleDescription =>
      'Select one option now. You can test farmer and worker accounts separately.';

  @override
  String get roleFarmerTitle => 'Farmer';

  @override
  String get roleFarmerDescription =>
      'Post labour jobs, find workers and manage farm operations.';

  @override
  String get roleWorkerTitle => 'Worker';

  @override
  String get roleWorkerDescription =>
      'Find nearby farm jobs and manage your daily work.';

  @override
  String get roleSelectHint => 'Select Farmer or Worker to continue';

  @override
  String get onboardingSlide1Title => 'Find trusted farm workers';

  @override
  String get onboardingSlide1Description =>
      'Connect with nearby verified workers for harvesting, irrigation, spraying and daily farm activities.';

  @override
  String get onboardingSlide2Title => 'Manage farm work in one place';

  @override
  String get onboardingSlide2Description =>
      'Check weather, post labour jobs, find nearby workers and track responses from your village area.';

  @override
  String get onboardingSlide3Title => 'Buy farming essentials nearby';

  @override
  String get onboardingSlide3Description =>
      'Discover fertilizers, pesticides, seeds and tools from nearby agricultural vendors.';

  @override
  String get onboardingSlide4Title => 'AI help and farming updates';

  @override
  String get onboardingSlide4Description =>
      'Get AI-ready farming guidance, weather alerts, crop updates and local agriculture news in one place.';

  @override
  String get loginWelcomeTitle => 'Welcome to KhetRojgar';

  @override
  String get loginWelcomeSubtitle =>
      'Securely login to manage your farm and access opportunities.';

  @override
  String get loginMobileLabel => 'Mobile number';

  @override
  String get loginMobileHint => 'Enter Mobile Number';

  @override
  String get loginContinueOtp => 'Continue with OTP';

  @override
  String get loginSendingOtp => 'Sending OTP...';

  @override
  String get loginOrContinueWith => 'or continue with';

  @override
  String get loginGoogle => 'Continue with Google';

  @override
  String get loginSelectRoleFirst => 'Please select a role first.';

  @override
  String get loginChooseGoogleAccount => 'Choose Google account';

  @override
  String loginContinueAsRole(Object role) {
    return 'Continue as $role with a saved local account.';
  }

  @override
  String get loginGoogleAccountsError => 'Could not load mock Google accounts';

  @override
  String get trustSecureLogin => 'Secure Login';

  @override
  String get trustDataPrivacy => 'Data Privacy';

  @override
  String get trustFastOtp => 'Fast OTP';

  @override
  String get otpTitle => 'Verify your OTP';

  @override
  String otpSubtitle(Object phoneNumber) {
    return 'Enter the 6-digit code sent to +91 $phoneNumber.';
  }

  @override
  String get otpVerifyButton => 'Verify and continue';

  @override
  String get otpVerifying => 'Verifying...';

  @override
  String get otpResendReady => 'Did not receive code?';

  @override
  String otpResendIn(int seconds) {
    return 'Resend OTP in ${seconds}s';
  }

  @override
  String get otpResendButton => 'Resend OTP';

  @override
  String get otpChangeMobile => 'Change mobile number';

  @override
  String get otpSentAgain => 'OTP sent again.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileLoading => 'Loading profile...';

  @override
  String get profileEditTitle => 'Edit profile';

  @override
  String get profileCompleteTitle => 'Complete profile';

  @override
  String get profileHeaderTitle => 'Complete your profile';

  @override
  String get profileHeaderFarmerSubtitle =>
      'Add the basics now. Farm details can be completed later.';

  @override
  String get profileHeaderWorkerSubtitle =>
      'Add the basics now. Work details can be completed later.';

  @override
  String get profileBasicDetails => 'Basic details';

  @override
  String get profileFullName => 'Full name';

  @override
  String get profileVerifiedMobile => 'Verified mobile';

  @override
  String get profileVerified => 'Verified';

  @override
  String profileVerifiedMobileA11y(Object phoneNumber) {
    return 'Verified mobile number $phoneNumber';
  }

  @override
  String get profileLocation => 'Location';

  @override
  String get profileVillageTown => 'Village / town';

  @override
  String get profileUseCurrentLocation => 'Use current location';

  @override
  String get profileLocationComingSoon =>
      'Location capture will be connected later.';

  @override
  String get profilePhotoTitle => 'Profile photo';

  @override
  String get profilePhotoOptional => 'Add profile photo (optional)';

  @override
  String get profilePhotoHelp => 'You can add this later from your profile';

  @override
  String get profilePhotoComingSoon => 'Photo upload will be connected later.';

  @override
  String get profileWorkDetails => 'Work details';

  @override
  String get profileChooseSkills => 'Choose your skills';

  @override
  String get profileSkillRequired => 'Select at least one skill';

  @override
  String get profileAvailableForWork => 'Available for work';

  @override
  String get profileAvailabilitySubtitle =>
      'Show availability in worker matching';

  @override
  String get profileSaveProfile => 'Save profile';

  @override
  String get profileSaveChanges => 'Save changes';

  @override
  String get skillHarvesting => 'Harvesting';

  @override
  String get skillIrrigation => 'Irrigation';

  @override
  String get skillTractor => 'Tractor';

  @override
  String get skillSpraying => 'Spraying';

  @override
  String get skillDairy => 'Dairy';

  @override
  String get skillSowing => 'Sowing';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsChangeLanguage => 'Change Language';

  @override
  String get settingsOfflineMode => 'Offline-first mode';

  @override
  String get settingsOfflineModeSubtitle =>
      'Profile, jobs, and sessions stay available locally.';
}
