import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AppBootstrap {
  const AppBootstrap._();

  static Future<void> initialize() async {
    await dotenv.load(fileName: 'assets/env/.env.development');
  }
}
