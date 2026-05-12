import 'package:farmmitra_app/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension LocaleBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
