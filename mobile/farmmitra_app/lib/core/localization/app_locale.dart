import 'dart:ui';

enum AppLocale {
  english(code: 'en', englishLabel: 'English', nativeLabel: 'English'),
  hindi(code: 'hi', englishLabel: 'Hindi', nativeLabel: 'हिंदी'),
  telugu(code: 'te', englishLabel: 'Telugu', nativeLabel: 'తెలుగు');

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

  static const supportedLocales = [Locale('en'), Locale('hi'), Locale('te')];

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
