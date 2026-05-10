import 'package:farmmitra_app/config/localization/app_language.dart';
import 'package:farmmitra_app/config/localization/language_controller.dart';
import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/shared/widgets/app_page_scaffold.dart';
import 'package:farmmitra_app/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionPage extends ConsumerStatefulWidget {
  const LanguageSelectionPage({this.isInitialSelection = false, super.key});

  final bool isInitialSelection;

  @override
  ConsumerState<LanguageSelectionPage> createState() =>
      _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends ConsumerState<LanguageSelectionPage> {
  AppLanguage? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final savedLanguage = ref.watch(languageControllerProvider).language;
    final selectedLanguage = _selectedLanguage ?? savedLanguage;

    return AppPageScaffold(
      title: widget.isInitialSelection ? 'Choose Language' : 'Change Language',
      showBackButton: !widget.isInitialSelection,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LanguageHeader(isInitialSelection: widget.isInitialSelection),
          const SizedBox(height: 16),
          for (final language in AppLanguage.values) ...[
            _LanguageCard(
              language: language,
              isSelected: selectedLanguage == language,
              onTap: () => setState(() => _selectedLanguage = language),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          if (_selectedLanguage != null || !widget.isInitialSelection)
            AppPrimaryButton(
              label: widget.isInitialSelection ? 'Continue' : 'Save Language',
              icon: Icons.arrow_forward,
              onPressed: () async {
                await ref
                    .read(languageControllerProvider.notifier)
                    .selectLanguage(selectedLanguage);
                if (context.mounted && widget.isInitialSelection) {
                  context.go(AppRoutes.onboarding);
                } else if (context.mounted) {
                  context.pop();
                }
              },
            ),
        ],
      ),
    );
  }
}

class _LanguageHeader extends StatelessWidget {
  const _LanguageHeader({required this.isInitialSelection});

  final bool isInitialSelection;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(Icons.translate_outlined, color: scheme.onPrimaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isInitialSelection
                    ? 'Select the language you read comfortably.'
                    : 'Change your saved app language.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: isSelected ? scheme.primaryContainer : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.nativeLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(language.label),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? scheme.primary : scheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
