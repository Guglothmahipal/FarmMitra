import 'dart:ui';

import 'package:farmmitra_app/core/localization/app_locale.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const selectedLocalePreferenceKey = 'selected_locale';

final localeControllerProvider =
    NotifierProvider<LocaleController, LocaleState>(LocaleController.new);

final localeStateOverrideProvider = Provider<LocaleState?>((ref) => null);

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden at startup.');
});

final class LocaleState {
  const LocaleState({
    required this.locale,
    required this.hasSelectedLocale,
    this.isChecking = false,
  });

  const LocaleState.checking()
    : locale = AppLocale.fallback,
      hasSelectedLocale = false,
      isChecking = true;

  final AppLocale locale;
  final bool hasSelectedLocale;
  final bool isChecking;
}

final class LocaleController extends Notifier<LocaleState> {
  @override
  LocaleState build() {
    final override = ref.watch(localeStateOverrideProvider);
    if (override != null) {
      return override;
    }

    Future<void>.microtask(_restoreLocale);
    return const LocaleState.checking();
  }

  Future<void> _restoreLocale() async {
    SharedPreferences? preferences;
    try {
      preferences = ref.read(sharedPreferencesProvider);
    } on UnimplementedError {
      preferences = null;
    }

    final savedCode = preferences?.getString(selectedLocalePreferenceKey);
    final fallbackLocale = savedCode == null
        ? AppLocale.fromDeviceLocales(PlatformDispatcher.instance.locales)
        : AppLocale.fromCode(savedCode);

    state = LocaleState(
      locale: fallbackLocale,
      hasSelectedLocale: savedCode != null,
    );
  }

  Future<void> selectLocale(AppLocale locale) async {
    state = LocaleState(locale: locale, hasSelectedLocale: true);
    try {
      await ref
          .read(sharedPreferencesProvider)
          .setString(selectedLocalePreferenceKey, locale.code);
    } on UnimplementedError {
      // Tests may not need persistent locale storage.
    }
  }
}
