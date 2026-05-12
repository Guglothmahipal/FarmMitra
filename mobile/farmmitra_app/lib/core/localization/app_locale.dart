import 'dart:ui';

enum AppLocale {
  english(code: 'en', englishLabel: 'English', nativeLabel: 'English'),
  hindi(code: 'hi', englishLabel: 'Hindi', nativeLabel: 'हिंदी'),
  telugu(code: 'te', englishLabel: 'Telugu', nativeLabel: 'తెలుగు'),
  tamil(code: 'ta', englishLabel: 'Tamil', nativeLabel: 'தமிழ்'),
  kannada(code: 'kn', englishLabel: 'Kannada', nativeLabel: 'ಕನ್ನಡ'),
  malayalam(code: 'ml', englishLabel: 'Malayalam', nativeLabel: 'മലയാളം'),
  marathi(code: 'mr', englishLabel: 'Marathi', nativeLabel: 'मराठी'),
  bengali(code: 'bn', englishLabel: 'Bengali', nativeLabel: 'বাংলা'),
  gujarati(code: 'gu', englishLabel: 'Gujarati', nativeLabel: 'ગુજરાતી'),
  punjabi(code: 'pa', englishLabel: 'Punjabi', nativeLabel: 'ਪੰਜਾਬੀ'),
  odia(code: 'or', englishLabel: 'Odia', nativeLabel: 'ଓଡ଼ିଆ');

  const AppLocale({
    required this.code,
    required this.englishLabel,
    required this.nativeLabel,
  });

  final String code;
  final String englishLabel;
  final String nativeLabel;

  Locale get locale => Locale(code);

  static const fallback = AppLocale.english;

  static const supportedLocales = [
    Locale('en'),
    Locale('hi'),
    Locale('te'),
    Locale('ta'),
    Locale('kn'),
    Locale('ml'),
    Locale('mr'),
    Locale('bn'),
    Locale('gu'),
    Locale('pa'),
    Locale('or'),
  ];

  static AppLocale fromCode(String? code) {
    return AppLocale.values.firstWhere(
      (locale) => locale.code == code,
      orElse: () => fallback,
    );
  }

  static AppLocale fromDeviceLocales(List<Locale> locales) {
    for (final locale in locales) {
      final match = AppLocale.values.where(
        (appLocale) => appLocale.code == locale.languageCode,
      );
      if (match.isNotEmpty) {
        return match.first;
      }
    }
    return fallback;
  }
}
