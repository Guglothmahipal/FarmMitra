import 'package:flutter/widgets.dart';

enum AppLanguage {
  english(code: 'en', label: 'English', nativeLabel: 'English'),
  hindi(code: 'hi', label: 'Hindi', nativeLabel: 'हिन्दी'),
  telugu(code: 'te', label: 'Telugu', nativeLabel: 'తెలుగు'),
  tamil(code: 'ta', label: 'Tamil', nativeLabel: 'தமிழ்'),
  kannada(code: 'kn', label: 'Kannada', nativeLabel: 'ಕನ್ನಡ'),
  malayalam(code: 'ml', label: 'Malayalam', nativeLabel: 'മലയാളം'),
  marathi(code: 'mr', label: 'Marathi', nativeLabel: 'मराठी'),
  bengali(code: 'bn', label: 'Bengali', nativeLabel: 'বাংলা'),
  gujarati(code: 'gu', label: 'Gujarati', nativeLabel: 'ગુજરાતી'),
  punjabi(code: 'pa', label: 'Punjabi', nativeLabel: 'ਪੰਜਾਬੀ'),
  odia(code: 'or', label: 'Odia', nativeLabel: 'ଓଡ଼ିଆ');

  const AppLanguage({
    required this.code,
    required this.label,
    required this.nativeLabel,
  });

  final String code;
  final String label;
  final String nativeLabel;

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String? code) {
    return AppLanguage.values.firstWhere(
      (language) => language.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}
