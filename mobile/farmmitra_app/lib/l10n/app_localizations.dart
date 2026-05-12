import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('te'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'KhetRojgar'**
  String get appName;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get commonGetStarted;

  /// No description provided for @commonSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get commonSaving;

  /// No description provided for @commonRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get commonRequired;

  /// No description provided for @languageChooseTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get languageChooseTitle;

  /// No description provided for @languageChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get languageChangeTitle;

  /// No description provided for @languageInitialPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select the language you read comfortably.'**
  String get languageInitialPrompt;

  /// No description provided for @languageChangePrompt.
  ///
  /// In en, this message translates to:
  /// **'Change your saved app language.'**
  String get languageChangePrompt;

  /// No description provided for @languageSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Language'**
  String get languageSaveButton;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get languageHindi;

  /// No description provided for @languageTelugu.
  ///
  /// In en, this message translates to:
  /// **'Telugu'**
  String get languageTelugu;

  /// No description provided for @roleHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your role to continue'**
  String get roleHeroSubtitle;

  /// No description provided for @roleQuestion.
  ///
  /// In en, this message translates to:
  /// **'How will you use KhetRojgar?'**
  String get roleQuestion;

  /// No description provided for @roleDescription.
  ///
  /// In en, this message translates to:
  /// **'Select one option now. You can test farmer and worker accounts separately.'**
  String get roleDescription;

  /// No description provided for @roleFarmerTitle.
  ///
  /// In en, this message translates to:
  /// **'Farmer'**
  String get roleFarmerTitle;

  /// No description provided for @roleFarmerDescription.
  ///
  /// In en, this message translates to:
  /// **'Post labour jobs, find workers and manage farm operations.'**
  String get roleFarmerDescription;

  /// No description provided for @roleWorkerTitle.
  ///
  /// In en, this message translates to:
  /// **'Worker'**
  String get roleWorkerTitle;

  /// No description provided for @roleWorkerDescription.
  ///
  /// In en, this message translates to:
  /// **'Find nearby farm jobs and manage your daily work.'**
  String get roleWorkerDescription;

  /// No description provided for @roleSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Select Farmer or Worker to continue'**
  String get roleSelectHint;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In en, this message translates to:
  /// **'Find trusted farm workers'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Description.
  ///
  /// In en, this message translates to:
  /// **'Connect with nearby verified workers for harvesting, irrigation, spraying and daily farm activities.'**
  String get onboardingSlide1Description;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In en, this message translates to:
  /// **'Manage farm work in one place'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Description.
  ///
  /// In en, this message translates to:
  /// **'Check weather, post labour jobs, find nearby workers and track responses from your village area.'**
  String get onboardingSlide2Description;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In en, this message translates to:
  /// **'Buy farming essentials nearby'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Description.
  ///
  /// In en, this message translates to:
  /// **'Discover fertilizers, pesticides, seeds and tools from nearby agricultural vendors.'**
  String get onboardingSlide3Description;

  /// No description provided for @onboardingSlide4Title.
  ///
  /// In en, this message translates to:
  /// **'AI help and farming updates'**
  String get onboardingSlide4Title;

  /// No description provided for @onboardingSlide4Description.
  ///
  /// In en, this message translates to:
  /// **'Get AI-ready farming guidance, weather alerts, crop updates and local agriculture news in one place.'**
  String get onboardingSlide4Description;

  /// No description provided for @loginWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to KhetRojgar'**
  String get loginWelcomeTitle;

  /// No description provided for @loginWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Securely login to manage your farm and access opportunities.'**
  String get loginWelcomeSubtitle;

  /// No description provided for @loginMobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get loginMobileLabel;

  /// No description provided for @loginMobileHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get loginMobileHint;

  /// No description provided for @loginContinueOtp.
  ///
  /// In en, this message translates to:
  /// **'Continue with OTP'**
  String get loginContinueOtp;

  /// No description provided for @loginSendingOtp.
  ///
  /// In en, this message translates to:
  /// **'Sending OTP...'**
  String get loginSendingOtp;

  /// No description provided for @loginOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get loginOrContinueWith;

  /// No description provided for @loginGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get loginGoogle;

  /// No description provided for @loginSelectRoleFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a role first.'**
  String get loginSelectRoleFirst;

  /// No description provided for @loginChooseGoogleAccount.
  ///
  /// In en, this message translates to:
  /// **'Choose Google account'**
  String get loginChooseGoogleAccount;

  /// No description provided for @loginContinueAsRole.
  ///
  /// In en, this message translates to:
  /// **'Continue as {role} with a saved local account.'**
  String loginContinueAsRole(Object role);

  /// No description provided for @loginGoogleAccountsError.
  ///
  /// In en, this message translates to:
  /// **'Could not load mock Google accounts'**
  String get loginGoogleAccountsError;

  /// No description provided for @trustSecureLogin.
  ///
  /// In en, this message translates to:
  /// **'Secure Login'**
  String get trustSecureLogin;

  /// No description provided for @trustDataPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Data Privacy'**
  String get trustDataPrivacy;

  /// No description provided for @trustFastOtp.
  ///
  /// In en, this message translates to:
  /// **'Fast OTP'**
  String get trustFastOtp;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your OTP'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to +91 {phoneNumber}.'**
  String otpSubtitle(Object phoneNumber);

  /// No description provided for @otpVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify and continue'**
  String get otpVerifyButton;

  /// No description provided for @otpVerifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get otpVerifying;

  /// No description provided for @otpResendReady.
  ///
  /// In en, this message translates to:
  /// **'Did not receive code?'**
  String get otpResendReady;

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in {seconds}s'**
  String otpResendIn(int seconds);

  /// No description provided for @otpResendButton.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get otpResendButton;

  /// No description provided for @otpChangeMobile.
  ///
  /// In en, this message translates to:
  /// **'Change mobile number'**
  String get otpChangeMobile;

  /// No description provided for @otpSentAgain.
  ///
  /// In en, this message translates to:
  /// **'OTP sent again.'**
  String get otpSentAgain;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading profile...'**
  String get profileLoading;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditTitle;

  /// No description provided for @profileCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete profile'**
  String get profileCompleteTitle;

  /// No description provided for @profileHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get profileHeaderTitle;

  /// No description provided for @profileHeaderFarmerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add the basics now. Farm details can be completed later.'**
  String get profileHeaderFarmerSubtitle;

  /// No description provided for @profileHeaderWorkerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add the basics now. Work details can be completed later.'**
  String get profileHeaderWorkerSubtitle;

  /// No description provided for @profileBasicDetails.
  ///
  /// In en, this message translates to:
  /// **'Basic details'**
  String get profileBasicDetails;

  /// No description provided for @profileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileFullName;

  /// No description provided for @profileVerifiedMobile.
  ///
  /// In en, this message translates to:
  /// **'Verified mobile'**
  String get profileVerifiedMobile;

  /// No description provided for @profileVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get profileVerified;

  /// No description provided for @profileVerifiedMobileA11y.
  ///
  /// In en, this message translates to:
  /// **'Verified mobile number {phoneNumber}'**
  String profileVerifiedMobileA11y(Object phoneNumber);

  /// No description provided for @profileLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get profileLocation;

  /// No description provided for @profileVillageTown.
  ///
  /// In en, this message translates to:
  /// **'Village / town'**
  String get profileVillageTown;

  /// No description provided for @profileUseCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use current location'**
  String get profileUseCurrentLocation;

  /// No description provided for @profileLocationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Location capture will be connected later.'**
  String get profileLocationComingSoon;

  /// No description provided for @profilePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get profilePhotoTitle;

  /// No description provided for @profilePhotoOptional.
  ///
  /// In en, this message translates to:
  /// **'Add profile photo (optional)'**
  String get profilePhotoOptional;

  /// No description provided for @profilePhotoHelp.
  ///
  /// In en, this message translates to:
  /// **'You can add this later from your profile'**
  String get profilePhotoHelp;

  /// No description provided for @profilePhotoComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Photo upload will be connected later.'**
  String get profilePhotoComingSoon;

  /// No description provided for @profileWorkDetails.
  ///
  /// In en, this message translates to:
  /// **'Work details'**
  String get profileWorkDetails;

  /// No description provided for @profileChooseSkills.
  ///
  /// In en, this message translates to:
  /// **'Choose your skills'**
  String get profileChooseSkills;

  /// No description provided for @profileSkillRequired.
  ///
  /// In en, this message translates to:
  /// **'Select at least one skill'**
  String get profileSkillRequired;

  /// No description provided for @profileAvailableForWork.
  ///
  /// In en, this message translates to:
  /// **'Available for work'**
  String get profileAvailableForWork;

  /// No description provided for @profileAvailabilitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show availability in worker matching'**
  String get profileAvailabilitySubtitle;

  /// No description provided for @profileSaveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get profileSaveProfile;

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get profileSaveChanges;

  /// No description provided for @skillHarvesting.
  ///
  /// In en, this message translates to:
  /// **'Harvesting'**
  String get skillHarvesting;

  /// No description provided for @skillIrrigation.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get skillIrrigation;

  /// No description provided for @skillTractor.
  ///
  /// In en, this message translates to:
  /// **'Tractor'**
  String get skillTractor;

  /// No description provided for @skillSpraying.
  ///
  /// In en, this message translates to:
  /// **'Spraying'**
  String get skillSpraying;

  /// No description provided for @skillDairy.
  ///
  /// In en, this message translates to:
  /// **'Dairy'**
  String get skillDairy;

  /// No description provided for @skillSowing.
  ///
  /// In en, this message translates to:
  /// **'Sowing'**
  String get skillSowing;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsChangeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get settingsChangeLanguage;

  /// No description provided for @settingsOfflineMode.
  ///
  /// In en, this message translates to:
  /// **'Offline-first mode'**
  String get settingsOfflineMode;

  /// No description provided for @settingsOfflineModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Profile, jobs, and sessions stay available locally.'**
  String get settingsOfflineModeSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
