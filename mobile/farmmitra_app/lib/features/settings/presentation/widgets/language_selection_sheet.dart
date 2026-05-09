import 'package:farmmitra_app/config/localization/app_language.dart';
import 'package:farmmitra_app/config/localization/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showLanguageSelectionSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
          final selectedLanguage = ref
              .watch(languageControllerProvider)
              .language;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose language',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Full translations will be added gradually. Your preference is saved on this device.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final language in AppLanguage.values)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(language.nativeLabel),
                      subtitle: Text(language.label),
                      trailing: selectedLanguage == language
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.circle_outlined),
                      onTap: () async {
                        await ref
                            .read(languageControllerProvider.notifier)
                            .selectLanguage(language);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
