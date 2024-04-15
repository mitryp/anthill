import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Action {
  delete,
  create,
  update,
  restore;

  String Function(Object identifier, String resourceName) localized(AppLocalizations locale) {
    return (identifier, resourceName) => switch (this) {
          delete => locale.logEntryDeleteAction(resourceName, identifier),
          create => locale.logEntryCreateAction(resourceName, identifier),
          update => locale.logEntryUpdateAction(resourceName, identifier),
          restore => locale.logEntryRestoreAction(resourceName, identifier),
        };
  }
}
