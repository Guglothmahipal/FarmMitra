import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavor { development, staging, production }

final class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.apiTimeoutSeconds,
    required this.enableNetworkLogging,
  });

  factory AppConfig.fromEnvironment() {
    final flavorName = dotenv.maybeGet('APP_FLAVOR') ?? 'development';

    return AppConfig(
      flavor: AppFlavor.values.firstWhere(
        (flavor) => flavor.name == flavorName,
        orElse: () => AppFlavor.development,
      ),
      apiBaseUrl:
          dotenv.maybeGet('API_BASE_URL') ?? 'https://api.farmmitra.local/v1',
      apiTimeoutSeconds:
          int.tryParse(dotenv.maybeGet('API_TIMEOUT_SECONDS') ?? '') ?? 20,
      enableNetworkLogging:
          (dotenv.maybeGet('ENABLE_NETWORK_LOGGING') ?? 'false') == 'true',
    );
  }

  final AppFlavor flavor;
  final String apiBaseUrl;
  final int apiTimeoutSeconds;
  final bool enableNetworkLogging;

  bool get isProduction => flavor == AppFlavor.production;
}
