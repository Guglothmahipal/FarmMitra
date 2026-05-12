// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'KhetRojgar';

  @override
  String get commonContinue => 'চালিয়ে যান';

  @override
  String get commonSave => 'সংরক্ষণ করুন';

  @override
  String get commonSkip => 'এড়িয়ে যান';

  @override
  String get commonNext => 'পরবর্তী';

  @override
  String get commonGetStarted => 'শুরু করুন';

  @override
  String get commonSaving => 'সংরক্ষণ হচ্ছে...';

  @override
  String get commonRequired => 'প্রয়োজনীয়';

  @override
  String get languageChooseTitle => 'ভাষা নির্বাচন করুন';

  @override
  String get languageChangeTitle => 'ভাষা বদলান';

  @override
  String get languageInitialPrompt =>
      'আপনি যে ভাষা সহজে পড়তে পারেন তা নির্বাচন করুন।';

  @override
  String get languageChangePrompt => 'আপনার সংরক্ষিত অ্যাপ ভাষা বদলান।';

  @override
  String get languageSaveButton => 'ভাষা সংরক্ষণ করুন';

  @override
  String get languageEnglish => 'ইংরেজি';

  @override
  String get languageHindi => 'হিন্দি';

  @override
  String get languageTelugu => 'তেলুগু';

  @override
  String get roleHeroSubtitle => 'চালিয়ে যেতে আপনার ভূমিকা নির্বাচন করুন';

  @override
  String get roleQuestion => 'আপনি KhetRojgar কীভাবে ব্যবহার করবেন?';

  @override
  String get roleDescription =>
      'এখন একটি বিকল্প নির্বাচন করুন। কৃষক ও শ্রমিক অ্যাকাউন্ট আলাদাভাবে পরীক্ষা করতে পারবেন।';

  @override
  String get roleFarmerTitle => 'কৃষক';

  @override
  String get roleFarmerDescription =>
      'শ্রমিকের কাজ পোস্ট করুন, শ্রমিক খুঁজুন এবং খামারের কাজ পরিচালনা করুন।';

  @override
  String get roleWorkerTitle => 'শ্রমিক';

  @override
  String get roleWorkerDescription =>
      'কাছাকাছি খামারের কাজ খুঁজুন এবং আপনার দৈনন্দিন কাজ পরিচালনা করুন।';

  @override
  String get roleSelectHint => 'চালিয়ে যেতে কৃষক বা শ্রমিক নির্বাচন করুন';

  @override
  String get onboardingSlide1Title => 'বিশ্বস্ত খামার শ্রমিক খুঁজুন';

  @override
  String get onboardingSlide1Description =>
      'ফসল কাটা, সেচ, স্প্রে এবং দৈনন্দিন খামারের কাজের জন্য কাছের যাচাইকৃত শ্রমিকদের সঙ্গে যুক্ত হন।';

  @override
  String get onboardingSlide2Title => 'খামারের কাজ এক জায়গায় পরিচালনা করুন';

  @override
  String get onboardingSlide2Description =>
      'আবহাওয়া দেখুন, শ্রমিকের কাজ পোস্ট করুন, কাছের শ্রমিক খুঁজুন এবং আপনার গ্রামের এলাকার সাড়া ট্র্যাক করুন।';

  @override
  String get onboardingSlide3Title => 'কাছাকাছি চাষের প্রয়োজনীয় জিনিস কিনুন';

  @override
  String get onboardingSlide3Description =>
      'সার, কীটনাশক, বীজ এবং সরঞ্জাম কাছের কৃষি বিক্রেতাদের কাছ থেকে খুঁজে নিন।';

  @override
  String get onboardingSlide4Title => 'AI সাহায্য এবং কৃষি আপডেট';

  @override
  String get onboardingSlide4Description =>
      'AI-রেডি কৃষি পরামর্শ, আবহাওয়া সতর্কতা, ফসল আপডেট এবং স্থানীয় কৃষি খবর এক জায়গায় পান।';

  @override
  String get loginWelcomeTitle => 'KhetRojgar-এ স্বাগতম';

  @override
  String get loginWelcomeSubtitle =>
      'আপনার খামার পরিচালনা করতে এবং সুযোগ পেতে নিরাপদে লগইন করুন।';

  @override
  String get loginMobileLabel => 'মোবাইল নম্বর';

  @override
  String get loginMobileHint => 'মোবাইল নম্বর লিখুন';

  @override
  String get loginContinueOtp => 'OTP দিয়ে চালিয়ে যান';

  @override
  String get loginSendingOtp => 'OTP পাঠানো হচ্ছে...';

  @override
  String get loginOrContinueWith => 'অথবা চালিয়ে যান';

  @override
  String get loginGoogle => 'Google দিয়ে চালিয়ে যান';

  @override
  String get loginSelectRoleFirst =>
      'অনুগ্রহ করে আগে একটি ভূমিকা নির্বাচন করুন।';

  @override
  String get loginChooseGoogleAccount => 'Google অ্যাকাউন্ট নির্বাচন করুন';

  @override
  String loginContinueAsRole(Object role) {
    return 'সংরক্ষিত স্থানীয় অ্যাকাউন্ট দিয়ে $role হিসেবে চালিয়ে যান।';
  }

  @override
  String get loginGoogleAccountsError => 'মক Google অ্যাকাউন্ট লোড করা যায়নি';

  @override
  String get trustSecureLogin => 'নিরাপদ লগইন';

  @override
  String get trustDataPrivacy => 'ডেটা গোপনীয়তা';

  @override
  String get trustFastOtp => 'দ্রুত OTP';

  @override
  String get otpTitle => 'আপনার OTP যাচাই করুন';

  @override
  String otpSubtitle(Object phoneNumber) {
    return '+91 $phoneNumber-এ পাঠানো 6 অঙ্কের কোড লিখুন।';
  }

  @override
  String get otpVerifyButton => 'যাচাই করে চালিয়ে যান';

  @override
  String get otpVerifying => 'যাচাই হচ্ছে...';

  @override
  String get otpResendReady => 'কোড পাননি?';

  @override
  String otpResendIn(int seconds) {
    return '${seconds}s পরে OTP আবার পাঠান';
  }

  @override
  String get otpResendButton => 'OTP আবার পাঠান';

  @override
  String get otpChangeMobile => 'মোবাইল নম্বর বদলান';

  @override
  String get otpSentAgain => 'OTP আবার পাঠানো হয়েছে।';

  @override
  String get profileTitle => 'প্রোফাইল';

  @override
  String get profileLoading => 'প্রোফাইল লোড হচ্ছে...';

  @override
  String get profileEditTitle => 'প্রোফাইল সম্পাদনা করুন';

  @override
  String get profileCompleteTitle => 'প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get profileHeaderTitle => 'আপনার প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get profileHeaderFarmerSubtitle =>
      'এখন প্রাথমিক তথ্য যোগ করুন। খামারের তথ্য পরে সম্পূর্ণ করা যাবে।';

  @override
  String get profileHeaderWorkerSubtitle =>
      'এখন প্রাথমিক তথ্য যোগ করুন। কাজের তথ্য পরে সম্পূর্ণ করা যাবে।';

  @override
  String get profileBasicDetails => 'মৌলিক তথ্য';

  @override
  String get profileFullName => 'পুরো নাম';

  @override
  String get profileVerifiedMobile => 'যাচাইকৃত মোবাইল';

  @override
  String get profileVerified => 'যাচাইকৃত';

  @override
  String profileVerifiedMobileA11y(Object phoneNumber) {
    return 'যাচাইকৃত মোবাইল নম্বর $phoneNumber';
  }

  @override
  String get profileLocation => 'অবস্থান';

  @override
  String get profileVillageTown => 'গ্রাম / শহর';

  @override
  String get profileUseCurrentLocation => 'বর্তমান অবস্থান ব্যবহার করুন';

  @override
  String get profileLocationComingSoon =>
      'অবস্থান নেওয়ার সুবিধা পরে যুক্ত হবে।';

  @override
  String get profilePhotoTitle => 'প্রোফাইল ছবি';

  @override
  String get profilePhotoOptional => 'প্রোফাইল ছবি যোগ করুন (ঐচ্ছিক)';

  @override
  String get profilePhotoHelp => 'এটি পরে আপনার প্রোফাইল থেকে যোগ করতে পারবেন';

  @override
  String get profilePhotoComingSoon => 'ছবি আপলোড পরে যুক্ত হবে।';

  @override
  String get profileWorkDetails => 'কাজের তথ্য';

  @override
  String get profileChooseSkills => 'আপনার দক্ষতা নির্বাচন করুন';

  @override
  String get profileSkillRequired => 'অন্তত একটি দক্ষতা নির্বাচন করুন';

  @override
  String get profileAvailableForWork => 'কাজের জন্য উপলব্ধ';

  @override
  String get profileAvailabilitySubtitle =>
      'শ্রমিক মিলানোর সময় উপলব্ধতা দেখান';

  @override
  String get profileSaveProfile => 'প্রোফাইল সংরক্ষণ করুন';

  @override
  String get profileSaveChanges => 'পরিবর্তন সংরক্ষণ করুন';

  @override
  String get skillHarvesting => 'ফসল কাটা';

  @override
  String get skillIrrigation => 'সেচ';

  @override
  String get skillTractor => 'ট্র্যাক্টর';

  @override
  String get skillSpraying => 'স্প্রে';

  @override
  String get skillDairy => 'দুগ্ধ';

  @override
  String get skillSowing => 'বপন';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get settingsChangeLanguage => 'ভাষা বদলান';

  @override
  String get settingsOfflineMode => 'অফলাইন-প্রথম মোড';

  @override
  String get settingsOfflineModeSubtitle =>
      'প্রোফাইল, কাজ এবং সেশন স্থানীয়ভাবে উপলব্ধ থাকে।';
}
