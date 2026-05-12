import 'package:farmmitra_app/core/localization/app_locale.dart';
import 'package:farmmitra_app/core/localization/locale_provider.dart';
import 'package:farmmitra_app/config/routing/app_router.dart';
import 'package:farmmitra_app/config/theme/app_theme.dart';
import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:farmmitra_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmMitraApp extends ConsumerWidget {
  const FarmMitraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final localeState = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      locale: localeState.locale.locale,
      supportedLocales: AppLocale.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    );
  }
}
