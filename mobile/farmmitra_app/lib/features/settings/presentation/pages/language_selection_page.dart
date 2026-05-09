import 'package:farmmitra_app/config/localization/app_language.dart';
import 'package:farmmitra_app/config/localization/language_controller.dart';
import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:farmmitra_app/shared/widgets/voice_instruction_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionPage extends ConsumerWidget {
  const LanguageSelectionPage({this.isInitialSelection = false, super.key});

  final bool isInitialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageControllerProvider).language;

    return AppPageScaffold(
      title: isInitialSelection ? 'Choose Language' : 'Change Language',
      showBackButton: !isInitialSelection,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.translate_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isInitialSelection
                        ? 'Select your app language'
                        : 'Language preference',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isInitialSelection
                        ? 'Choose the language you are comfortable reading. Full translations will be added gradually.'
                        : 'FarmMitra is localization-ready. Full screen translations will be connected in upcoming milestones.',
                  ),
                  if (isInitialSelection) ...[
                    const SizedBox(height: 12),
                    const VoiceInstructionButton(
                      instruction:
                          'Choose the language you can read most comfortably. You can change it later in settings.',
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final language in AppLanguage.values)
            Card(
              child: ListTile(
                title: Text(language.nativeLabel),
                subtitle: Text(language.label),
                trailing: selectedLanguage == language
                    ? const Icon(Icons.check_circle)
                    : const Icon(Icons.circle_outlined),
                onTap: () async {
                  await ref
                      .read(languageControllerProvider.notifier)
                      .selectLanguage(language);
                  if (context.mounted && isInitialSelection) {
                    context.go(AppRoutes.onboarding);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
