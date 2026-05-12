import 'package:farmmitra_app/config/routing/app_routes.dart';
import 'package:farmmitra_app/core/localization/app_locale.dart';
import 'package:farmmitra_app/core/localization/locale_extensions.dart';
import 'package:farmmitra_app/core/localization/locale_provider.dart';
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
  AppLocale? _selectedLocale;

  @override
  Widget build(BuildContext context) {
    final selectedLocale = _selectedLocale;
    final l10n = context.l10n;

    return AppPageScaffold(
      title: widget.isInitialSelection
          ? l10n.languageChooseTitle
          : l10n.languageChangeTitle,
      showBackButton: !widget.isInitialSelection,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              children: [
                _LanguageHeader(isInitialSelection: widget.isInitialSelection),
                const SizedBox(height: 16),
                for (final locale in AppLocale.values) ...[
                  _LanguageCard(
                    locale: locale,
                    isSelected: selectedLocale == locale,
                    onTap: () => setState(() => _selectedLocale = locale),
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          _BottomLanguageAction(
            isVisible: selectedLocale != null,
            label: widget.isInitialSelection
                ? l10n.commonContinue
                : l10n.languageSaveButton,
            onPressed: selectedLocale == null
                ? null
                : () async {
                    await ref
                        .read(localeControllerProvider.notifier)
                        .selectLocale(selectedLocale);
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

class _BottomLanguageAction extends StatelessWidget {
  const _BottomLanguageAction({
    required this.isVisible,
    required this.label,
    required this.onPressed,
  });

  final bool isVisible;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 240),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, 0.18),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },
      child: isVisible
          ? DecoratedBox(
              key: const ValueKey('language-bottom-action'),
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(top: BorderSide(color: scheme.outlineVariant)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 18,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: AppPrimaryButton(
                    label: label,
                    icon: Icons.arrow_forward,
                    onPressed: onPressed,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(key: ValueKey('language-bottom-empty')),
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
                    ? context.l10n.languageInitialPrompt
                    : context.l10n.languageChangePrompt,
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
    required this.locale,
    required this.isSelected,
    required this.onTap,
  });

  final AppLocale locale;
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
                      locale.nativeLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(locale.englishLabel),
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
