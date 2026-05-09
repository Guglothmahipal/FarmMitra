import 'package:farmmitra_app/config/routing/app_router.dart';
import 'package:farmmitra_app/config/theme/app_theme.dart';
import 'package:farmmitra_app/config/localization/app_localizations.dart';
import 'package:farmmitra_app/config/localization/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmMitraApp extends ConsumerWidget {
  const FarmMitraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final languageState = ref.watch(languageControllerProvider);

    return MaterialApp.router(
      title: 'FarmMitra',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      locale: languageState.language.locale,
      supportedLocales: [
        for (final language in AppLocalizations.supportedLanguages)
          language.locale,
      ],
      routerConfig: router,
    );
  }
}
