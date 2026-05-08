import 'package:farmmitra_app/app/app_bootstrap.dart';
import 'package:farmmitra_app/app/farmmitra_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.initialize();

  runApp(const ProviderScope(child: FarmMitraApp()));
}
