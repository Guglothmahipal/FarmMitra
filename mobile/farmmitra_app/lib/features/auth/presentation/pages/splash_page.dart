import 'package:farmmitra_app/config/localization/language_controller.dart';
import 'package:farmmitra_app/core/constants/app_constants.dart';
import 'package:farmmitra_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authControllerProvider);
    final languageState = ref.watch(languageControllerProvider);
    final roleLabel = authState.selectedRole?.label;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: scheme.primaryContainer,
                  foregroundColor: scheme.onPrimaryContainer,
                  child: const Icon(Icons.agriculture, size: 48),
                ),
                const SizedBox(height: 20),
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _statusText(
                    roleLabel: roleLabel,
                    languageReady: !languageState.isChecking,
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                const LinearProgressIndicator(),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    Chip(
                      avatar: Icon(Icons.offline_bolt_outlined, size: 16),
                      label: Text('Offline ready'),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      avatar: Icon(Icons.lock_outline, size: 16),
                      label: Text('Session check'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusText({
    required String? roleLabel,
    required bool languageReady,
  }) {
    if (!languageReady) {
      return 'Preparing language preference...';
    }
    if (roleLabel != null) {
      return 'Restoring $roleLabel session and local data...';
    }
    return 'Checking onboarding, login, and offline data...';
  }
}
