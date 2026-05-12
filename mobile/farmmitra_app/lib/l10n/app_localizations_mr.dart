// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appName => 'KhetRojgar';

  @override
  String get commonContinue => 'सुरू ठेवा';

  @override
  String get commonSave => 'जतन करा';

  @override
  String get commonSkip => 'वगळा';

  @override
  String get commonNext => 'पुढे';

  @override
  String get commonGetStarted => 'सुरू करा';

  @override
  String get commonSaving => 'जतन करत आहे...';

  @override
  String get commonRequired => 'आवश्यक';

  @override
  String get languageChooseTitle => 'भाषा निवडा';

  @override
  String get languageChangeTitle => 'भाषा बदला';

  @override
  String get languageInitialPrompt => 'तुम्हाला सहज वाचता येणारी भाषा निवडा.';

  @override
  String get languageChangePrompt => 'तुमची जतन केलेली अॅप भाषा बदला.';

  @override
  String get languageSaveButton => 'भाषा जतन करा';

  @override
  String get languageEnglish => 'इंग्रजी';

  @override
  String get languageHindi => 'हिंदी';

  @override
  String get languageTelugu => 'तेलुगू';

  @override
  String get roleHeroSubtitle => 'पुढे जाण्यासाठी तुमची भूमिका निवडा';

  @override
  String get roleQuestion => 'तुम्ही KhetRojgar कसे वापरणार?';

  @override
  String get roleDescription =>
      'आता एक पर्याय निवडा. शेतकरी आणि कामगार खाती वेगवेगळी तपासू शकता.';

  @override
  String get roleFarmerTitle => 'शेतकरी';

  @override
  String get roleFarmerDescription =>
      'मजुरीची कामे पोस्ट करा, कामगार शोधा आणि शेतीची कामे सांभाळा.';

  @override
  String get roleWorkerTitle => 'कामगार';

  @override
  String get roleWorkerDescription =>
      'जवळची शेतीची कामे शोधा आणि तुमचे दैनंदिन काम सांभाळा.';

  @override
  String get roleSelectHint => 'पुढे जाण्यासाठी शेतकरी किंवा कामगार निवडा';

  @override
  String get onboardingSlide1Title => 'विश्वासू शेतमजूर शोधा';

  @override
  String get onboardingSlide1Description =>
      'कापणी, सिंचन, फवारणी आणि दैनंदिन शेती कामांसाठी जवळच्या पडताळलेल्या कामगारांशी जोडा.';

  @override
  String get onboardingSlide2Title => 'शेतीची कामे एका ठिकाणी सांभाळा';

  @override
  String get onboardingSlide2Description =>
      'हवामान पाहा, मजुरीची कामे पोस्ट करा, जवळचे कामगार शोधा आणि गावातील प्रतिसाद ट्रॅक करा.';

  @override
  String get onboardingSlide3Title => 'जवळची शेतीची आवश्यक वस्तू खरेदी करा';

  @override
  String get onboardingSlide3Description =>
      'खते, कीटकनाशके, बियाणे आणि साधने जवळच्या कृषी विक्रेत्यांकडून शोधा.';

  @override
  String get onboardingSlide4Title => 'AI मदत आणि शेती अपडेट्स';

  @override
  String get onboardingSlide4Description =>
      'AI-सज्ज शेती मार्गदर्शन, हवामान सूचना, पिकांचे अपडेट्स आणि स्थानिक कृषी बातम्या एकाच ठिकाणी मिळवा.';

  @override
  String get loginWelcomeTitle => 'KhetRojgar मध्ये स्वागत';

  @override
  String get loginWelcomeSubtitle =>
      'तुमचे शेत व्यवस्थापित करण्यासाठी आणि संधी मिळवण्यासाठी सुरक्षितपणे लॉगिन करा.';

  @override
  String get loginMobileLabel => 'मोबाईल नंबर';

  @override
  String get loginMobileHint => 'मोबाईल नंबर टाका';

  @override
  String get loginContinueOtp => 'OTP सह सुरू ठेवा';

  @override
  String get loginSendingOtp => 'OTP पाठवत आहे...';

  @override
  String get loginOrContinueWith => 'किंवा यासह सुरू ठेवा';

  @override
  String get loginGoogle => 'Google सह सुरू ठेवा';

  @override
  String get loginSelectRoleFirst => 'कृपया आधी भूमिका निवडा.';

  @override
  String get loginChooseGoogleAccount => 'Google खाते निवडा';

  @override
  String loginContinueAsRole(Object role) {
    return 'जतन केलेल्या स्थानिक खात्यासह $role म्हणून सुरू ठेवा.';
  }

  @override
  String get loginGoogleAccountsError => 'मॉक Google खाती लोड करता आली नाहीत';

  @override
  String get trustSecureLogin => 'सुरक्षित लॉगिन';

  @override
  String get trustDataPrivacy => 'डेटा गोपनीयता';

  @override
  String get trustFastOtp => 'जलद OTP';

  @override
  String get otpTitle => 'तुमचा OTP पडताळा';

  @override
  String otpSubtitle(Object phoneNumber) {
    return '+91 $phoneNumber वर पाठवलेला 6 अंकी कोड टाका.';
  }

  @override
  String get otpVerifyButton => 'पडताळा आणि सुरू ठेवा';

  @override
  String get otpVerifying => 'पडताळत आहे...';

  @override
  String get otpResendReady => 'कोड मिळाला नाही?';

  @override
  String otpResendIn(int seconds) {
    return '${seconds}s मध्ये OTP पुन्हा पाठवा';
  }

  @override
  String get otpResendButton => 'OTP पुन्हा पाठवा';

  @override
  String get otpChangeMobile => 'मोबाईल नंबर बदला';

  @override
  String get otpSentAgain => 'OTP पुन्हा पाठवला.';

  @override
  String get profileTitle => 'प्रोफाइल';

  @override
  String get profileLoading => 'प्रोफाइल लोड होत आहे...';

  @override
  String get profileEditTitle => 'प्रोफाइल संपादित करा';

  @override
  String get profileCompleteTitle => 'प्रोफाइल पूर्ण करा';

  @override
  String get profileHeaderTitle => 'तुमचे प्रोफाइल पूर्ण करा';

  @override
  String get profileHeaderFarmerSubtitle =>
      'मूलभूत माहिती आता जोडा. शेताची माहिती नंतर पूर्ण करता येईल.';

  @override
  String get profileHeaderWorkerSubtitle =>
      'मूलभूत माहिती आता जोडा. कामाची माहिती नंतर पूर्ण करता येईल.';

  @override
  String get profileBasicDetails => 'मूलभूत माहिती';

  @override
  String get profileFullName => 'पूर्ण नाव';

  @override
  String get profileVerifiedMobile => 'पडताळलेला मोबाईल';

  @override
  String get profileVerified => 'पडताळलेले';

  @override
  String profileVerifiedMobileA11y(Object phoneNumber) {
    return 'पडताळलेला मोबाईल नंबर $phoneNumber';
  }

  @override
  String get profileLocation => 'स्थान';

  @override
  String get profileVillageTown => 'गाव / शहर';

  @override
  String get profileUseCurrentLocation => 'सध्याचे स्थान वापरा';

  @override
  String get profileLocationComingSoon => 'स्थान कॅप्चर नंतर जोडले जाईल.';

  @override
  String get profilePhotoTitle => 'प्रोफाइल फोटो';

  @override
  String get profilePhotoOptional => 'प्रोफाइल फोटो जोडा (ऐच्छिक)';

  @override
  String get profilePhotoHelp => 'हे तुम्ही नंतर प्रोफाइलमधून जोडू शकता';

  @override
  String get profilePhotoComingSoon => 'फोटो अपलोड नंतर जोडले जाईल.';

  @override
  String get profileWorkDetails => 'कामाची माहिती';

  @override
  String get profileChooseSkills => 'तुमची कौशल्ये निवडा';

  @override
  String get profileSkillRequired => 'किमान एक कौशल्य निवडा';

  @override
  String get profileAvailableForWork => 'कामासाठी उपलब्ध';

  @override
  String get profileAvailabilitySubtitle => 'कामगार जुळणीत उपलब्धता दाखवा';

  @override
  String get profileSaveProfile => 'प्रोफाइल जतन करा';

  @override
  String get profileSaveChanges => 'बदल जतन करा';

  @override
  String get skillHarvesting => 'कापणी';

  @override
  String get skillIrrigation => 'सिंचन';

  @override
  String get skillTractor => 'ट्रॅक्टर';

  @override
  String get skillSpraying => 'फवारणी';

  @override
  String get skillDairy => 'दुग्धव्यवसाय';

  @override
  String get skillSowing => 'पेरणी';

  @override
  String get settingsTitle => 'सेटिंग्ज';

  @override
  String get settingsChangeLanguage => 'भाषा बदला';

  @override
  String get settingsOfflineMode => 'ऑफलाइन-प्रथम मोड';

  @override
  String get settingsOfflineModeSubtitle =>
      'प्रोफाइल, कामे आणि सत्रे स्थानिक पातळीवर उपलब्ध राहतात.';
}
