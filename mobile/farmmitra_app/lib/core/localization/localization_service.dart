import 'package:farmmitra_app/core/localization/app_locale.dart';
import 'package:intl/intl.dart';

final class LocalizationService {
  const LocalizationService._();

  static const supportedLocales = AppLocale.supportedLocales;

  static bool isSupported(String languageCode) {
    return AppLocale.values.any((locale) => locale.code == languageCode);
  }

  static AppLocale resolve(String? languageCode) {
    return AppLocale.fromCode(languageCode);
  }

  static String acceptLanguageHeader(AppLocale locale) => locale.code;

  static String formatNumber(num value, AppLocale locale) {
    return NumberFormat.decimalPattern(locale.code).format(value);
  }

  static String formatCurrency(
    num value,
    AppLocale locale, {
    String symbol = '₹',
  }) {
    return NumberFormat.currency(
      locale: locale.code,
      symbol: symbol,
      decimalDigits: 0,
    ).format(value);
  }

  static String formatDate(
    DateTime value,
    AppLocale locale, {
    String pattern = 'dd MMM yyyy',
  }) {
    return DateFormat(pattern, locale.code).format(value);
  }

  static bool isRtl(AppLocale locale) {
    return false;
  }
}
