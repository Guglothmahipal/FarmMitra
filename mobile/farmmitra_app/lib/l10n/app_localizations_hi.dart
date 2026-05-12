// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'खेत रोजगार';

  @override
  String get commonContinue => 'आगे बढ़ें';

  @override
  String get commonSave => 'सेव करें';

  @override
  String get commonSkip => 'छोड़ें';

  @override
  String get commonNext => 'अगला';

  @override
  String get commonGetStarted => 'शुरू करें';

  @override
  String get commonSaving => 'सेव हो रहा है...';

  @override
  String get commonRequired => 'ज़रूरी है';

  @override
  String get languageChooseTitle => 'भाषा चुनें';

  @override
  String get languageChangeTitle => 'भाषा बदलें';

  @override
  String get languageInitialPrompt =>
      'वह भाषा चुनें जिसे आप आसानी से पढ़ सकें।';

  @override
  String get languageChangePrompt => 'ऐप की सेव की गई भाषा बदलें।';

  @override
  String get languageSaveButton => 'भाषा सेव करें';

  @override
  String get languageEnglish => 'अंग्रेज़ी';

  @override
  String get languageHindi => 'हिंदी';

  @override
  String get languageTelugu => 'तेलुगु';

  @override
  String get roleHeroSubtitle => 'आगे बढ़ने के लिए अपनी भूमिका चुनें';

  @override
  String get roleQuestion => 'आप खेत रोजगार कैसे इस्तेमाल करेंगे?';

  @override
  String get roleDescription =>
      'अभी एक विकल्प चुनें। किसान और मजदूर खाते अलग-अलग टेस्ट कर सकते हैं।';

  @override
  String get roleFarmerTitle => 'किसान';

  @override
  String get roleFarmerDescription =>
      'मजदूरी काम पोस्ट करें, मजदूर खोजें और खेती का काम संभालें।';

  @override
  String get roleWorkerTitle => 'मजदूर';

  @override
  String get roleWorkerDescription =>
      'पास के खेत काम खोजें और अपना रोज़ का काम संभालें।';

  @override
  String get roleSelectHint => 'आगे बढ़ने के लिए किसान या मजदूर चुनें';

  @override
  String get onboardingSlide1Title => 'भरोसेमंद खेत मजदूर खोजें';

  @override
  String get onboardingSlide1Description =>
      'कटाई, सिंचाई, छिड़काव और रोज़ के खेत काम के लिए पास के सत्यापित मजदूरों से जुड़ें।';

  @override
  String get onboardingSlide2Title => 'खेती का काम एक जगह संभालें';

  @override
  String get onboardingSlide2Description =>
      'मौसम देखें, मजदूरी काम पोस्ट करें, पास के मजदूर खोजें और गांव से जवाब ट्रैक करें।';

  @override
  String get onboardingSlide3Title => 'पास में खेती का सामान खरीदें';

  @override
  String get onboardingSlide3Description =>
      'पास के कृषि विक्रेताओं से खाद, दवा, बीज और औज़ार खोजें।';

  @override
  String get onboardingSlide4Title => 'AI मदद और खेती अपडेट';

  @override
  String get onboardingSlide4Description =>
      'AI-ready खेती सलाह, मौसम अलर्ट, फसल अपडेट और स्थानीय कृषि खबरें एक जगह पाएं।';

  @override
  String get loginWelcomeTitle => 'खेत रोजगार में स्वागत है';

  @override
  String get loginWelcomeSubtitle =>
      'अपना खेत संभालने और काम के मौके पाने के लिए सुरक्षित लॉगिन करें।';

  @override
  String get loginMobileLabel => 'मोबाइल नंबर';

  @override
  String get loginMobileHint => 'मोबाइल नंबर डालें';

  @override
  String get loginContinueOtp => 'OTP से आगे बढ़ें';

  @override
  String get loginSendingOtp => 'OTP भेज रहे हैं...';

  @override
  String get loginOrContinueWith => 'या इससे आगे बढ़ें';

  @override
  String get loginGoogle => 'Google से जारी रखें';

  @override
  String get loginSelectRoleFirst => 'कृपया पहले भूमिका चुनें।';

  @override
  String get loginChooseGoogleAccount => 'Google खाता चुनें';

  @override
  String loginContinueAsRole(Object role) {
    return '$role के रूप में सेव किए गए स्थानीय खाते से आगे बढ़ें।';
  }

  @override
  String get loginGoogleAccountsError => 'Mock Google खाते लोड नहीं हो सके';

  @override
  String get trustSecureLogin => 'सुरक्षित लॉगिन';

  @override
  String get trustDataPrivacy => 'डेटा गोपनीयता';

  @override
  String get trustFastOtp => 'तेज़ OTP';

  @override
  String get otpTitle => 'अपना OTP सत्यापित करें';

  @override
  String otpSubtitle(Object phoneNumber) {
    return '+91 $phoneNumber पर भेजा गया 6 अंकों का कोड डालें।';
  }

  @override
  String get otpVerifyButton => 'सत्यापित कर आगे बढ़ें';

  @override
  String get otpVerifying => 'सत्यापित हो रहा है...';

  @override
  String get otpResendReady => 'कोड नहीं मिला?';

  @override
  String otpResendIn(int seconds) {
    return '${seconds}s में OTP फिर भेजें';
  }

  @override
  String get otpResendButton => 'OTP फिर भेजें';

  @override
  String get otpChangeMobile => 'मोबाइल नंबर बदलें';

  @override
  String get otpSentAgain => 'OTP फिर भेज दिया गया।';

  @override
  String get profileTitle => 'प्रोफाइल';

  @override
  String get profileLoading => 'प्रोफाइल लोड हो रही है...';

  @override
  String get profileEditTitle => 'प्रोफाइल संपादित करें';

  @override
  String get profileCompleteTitle => 'प्रोफाइल पूरी करें';

  @override
  String get profileHeaderTitle => 'अपनी प्रोफाइल पूरी करें';

  @override
  String get profileHeaderFarmerSubtitle =>
      'अभी केवल जरूरी जानकारी जोड़ें। खेत की जानकारी बाद में जोड़ सकते हैं।';

  @override
  String get profileHeaderWorkerSubtitle =>
      'अभी केवल जरूरी जानकारी जोड़ें। काम की जानकारी बाद में जोड़ सकते हैं।';

  @override
  String get profileBasicDetails => 'बुनियादी जानकारी';

  @override
  String get profileFullName => 'पूरा नाम';

  @override
  String get profileVerifiedMobile => 'सत्यापित मोबाइल';

  @override
  String get profileVerified => 'सत्यापित';

  @override
  String profileVerifiedMobileA11y(Object phoneNumber) {
    return 'सत्यापित मोबाइल नंबर $phoneNumber';
  }

  @override
  String get profileLocation => 'स्थान';

  @override
  String get profileVillageTown => 'गांव / कस्बा';

  @override
  String get profileUseCurrentLocation => 'मौजूदा स्थान इस्तेमाल करें';

  @override
  String get profileLocationComingSoon => 'स्थान कैप्चर बाद में जोड़ा जाएगा।';

  @override
  String get profilePhotoTitle => 'प्रोफाइल फोटो';

  @override
  String get profilePhotoOptional => 'प्रोफाइल फोटो जोड़ें (वैकल्पिक)';

  @override
  String get profilePhotoHelp => 'इसे बाद में प्रोफाइल से जोड़ सकते हैं';

  @override
  String get profilePhotoComingSoon => 'फोटो अपलोड बाद में जोड़ा जाएगा।';

  @override
  String get profileWorkDetails => 'काम की जानकारी';

  @override
  String get profileChooseSkills => 'अपने कौशल चुनें';

  @override
  String get profileSkillRequired => 'कम से कम एक कौशल चुनें';

  @override
  String get profileAvailableForWork => 'काम के लिए उपलब्ध';

  @override
  String get profileAvailabilitySubtitle => 'मजदूर मिलान में उपलब्धता दिखाएं';

  @override
  String get profileSaveProfile => 'प्रोफाइल सेव करें';

  @override
  String get profileSaveChanges => 'बदलाव सेव करें';

  @override
  String get skillHarvesting => 'कटाई';

  @override
  String get skillIrrigation => 'सिंचाई';

  @override
  String get skillTractor => 'ट्रैक्टर';

  @override
  String get skillSpraying => 'छिड़काव';

  @override
  String get skillDairy => 'डेयरी';

  @override
  String get skillSowing => 'बुवाई';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsChangeLanguage => 'भाषा बदलें';

  @override
  String get settingsOfflineMode => 'ऑफलाइन-फर्स्ट मोड';

  @override
  String get settingsOfflineModeSubtitle =>
      'प्रोफाइल, काम और सत्र इस डिवाइस पर उपलब्ध रहेंगे।';
}
