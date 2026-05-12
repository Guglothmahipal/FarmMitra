import 'package:farmmitra_app/core/localization/app_locale.dart';

final class LocalizationService {
  const LocalizationService._();

  static const supportedLocales = AppLocale.supportedLocales;

  static bool isSupported(String languageCode) {
    return AppLocale.values.any((locale) => locale.code == languageCode);
  }

  static AppLocale resolve(String? languageCode) {
    return AppLocale.fromCode(languageCode);
  }
}
