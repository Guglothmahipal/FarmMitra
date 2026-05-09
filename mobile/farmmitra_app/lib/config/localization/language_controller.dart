import 'package:farmmitra_app/config/localization/app_language.dart';
import 'package:farmmitra_app/core/storage/secure_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageControllerProvider =
    NotifierProvider<LanguageController, LanguageState>(LanguageController.new);

final languageStateOverrideProvider = Provider<LanguageState?>((ref) => null);

final class LanguageState {
  const LanguageState({
    required this.language,
    required this.hasSelectedLanguage,
    this.isChecking = false,
  });

  const LanguageState.checking()
    : language = AppLanguage.english,
      hasSelectedLanguage = false,
      isChecking = true;

  final AppLanguage language;
  final bool hasSelectedLanguage;
  final bool isChecking;
}

final class LanguageController extends Notifier<LanguageState> {
  @override
  LanguageState build() {
    final override = ref.watch(languageStateOverrideProvider);
    if (override != null) {
      return override;
    }

    Future<void>.microtask(_restoreLanguage);
    return const LanguageState.checking();
  }

  Future<void> _restoreLanguage() async {
    final code = await ref.read(secureStorageProvider).readLanguageCode();
    state = LanguageState(
      language: AppLanguage.fromCode(code),
      hasSelectedLanguage: code != null,
    );
  }

  Future<void> selectLanguage(AppLanguage language) async {
    state = LanguageState(language: language, hasSelectedLanguage: true);
    await ref.read(secureStorageProvider).saveLanguageCode(language.code);
  }
}
