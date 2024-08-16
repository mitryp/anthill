import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Module {
  transactions,
  users;

  String localizedResourceName(AppLocalizations locale) => switch (this) {
        transactions => locale.resourceNameTransaction,
        users => locale.resourceNameUser,
      };

  String localizedName(AppLocalizations locale) => switch (this) {
        transactions => locale.moduleNameTransactions,
        users => locale.moduleNameUsers,
      };
}
