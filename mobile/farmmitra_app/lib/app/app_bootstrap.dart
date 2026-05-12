import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AppBootstrap {
  const AppBootstrap._();

  static Future<AppBootstrapResult> initialize() async {
    await dotenv.load(fileName: 'assets/env/.env.development');
    final sharedPreferences = await SharedPreferences.getInstance();

    return AppBootstrapResult(sharedPreferences: sharedPreferences);
  }
}

final class AppBootstrapResult {
  const AppBootstrapResult({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;
}
