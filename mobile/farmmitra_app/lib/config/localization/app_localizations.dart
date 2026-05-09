import 'package:farmmitra_app/config/localization/app_language.dart';

final class AppLocalizations {
  const AppLocalizations._();

  static const supportedLanguages = AppLanguage.values;

  static const placeholderKeys = <String>[
    'app.title',
    'navigation.home',
    'navigation.jobs',
    'navigation.alerts',
    'navigation.profile',
    'settings.changeLanguage',
  ];
}
