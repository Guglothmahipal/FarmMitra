import 'package:farmmitra_app/app/app_bootstrap.dart';
import 'package:farmmitra_app/app/farmmitra_app.dart';
import 'package:farmmitra_app/core/localization/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bootstrap = await AppBootstrap.initialize();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          bootstrap.sharedPreferences,
        ),
      ],
      child: const FarmMitraApp(),
    ),
  );
}
