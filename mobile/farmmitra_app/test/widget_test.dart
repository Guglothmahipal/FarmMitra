import 'package:farmmitra_app/app/farmmitra_app.dart';
import 'package:farmmitra_app/config/env/app_config.dart';
import 'package:farmmitra_app/core/network/network_status.dart';
import 'package:farmmitra_app/features/home/domain/entities/architecture_status.dart';
import 'package:farmmitra_app/features/home/presentation/controllers/home_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows FarmMitra architecture foundation', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          architectureStatusProvider.overrideWith(
            (ref) async => const ArchitectureStatus(
              flavor: AppFlavor.development,
              apiBaseUrl: 'https://api.farmmitra.local/v1',
              networkStatus: NetworkStatus.online,
              pendingSyncItems: 0,
              localDatabaseReady: true,
            ),
          ),
        ],
        child: const FarmMitraApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('FarmMitra'), findsOneWidget);
    expect(find.text('Architecture foundation'), findsOneWidget);
    expect(find.text('Local database'), findsOneWidget);
  });
}
