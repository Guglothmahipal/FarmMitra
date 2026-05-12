import 'package:farmmitra_app/core/localization/app_locale.dart';
import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:farmmitra_app/core/localization/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showLanguageSelectionSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return Consumer(
        builder: (context, ref, _) {
          final selectedLocale = ref.watch(localeControllerProvider).locale;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.languageChooseTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.languageChangePrompt,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final locale in AppLocale.values)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(locale.nativeLabel),
                      subtitle: Text(locale.englishLabel),
                      trailing: selectedLocale == locale
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.circle_outlined),
                      onTap: () async {
                        await ref
                            .read(localeControllerProvider.notifier)
                            .selectLocale(locale);
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
