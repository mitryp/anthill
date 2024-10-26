import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../shared/navigation.dart';
import '../../../shared/widgets.dart';
import '../domain/dtos/log_entry_read_dto.dart';

class LogEntryTile extends StatelessWidget {
  final LogEntryReadDto logEntry;

  const LogEntryTile({required this.logEntry, super.key});

  void Function(BuildContext context)? _buildRedirectToAffectedResource() {
    final targetPage = switch (logEntry.resourceAffected) {
      'transaction' => AppPage.transaction,
      'user' => AppPage.user,
      _ => null,
    };

    return (context) {
      if (targetPage == null) {
        if (logEntry.resourceAffected != null) {
          final locale = context.locale;

          showSnackBar(
            context,
            title: Text(
              locale.errorMissingLinkForResource(logEntry.resourceAffected ?? 'unknown'),
            ),
            subtitle: Text(locale.supportReportEncouragement),
            backgroundColor: Colors.red.shade200,
          );
        }

        return;
      }

      context.pushPage(targetPage, resourceId: logEntry.targetEntityId);
    };
  }

  TextSpan _localizeEntryTitle(BuildContext context) {
    final locale = context.locale;

    return TextSpan(
      children: [
        TextSpan(text: locale.logEntryActionPerformedBy(_localizeAction(locale))),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: TextButton(
            child: Text(
              logEntry.user.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            onPressed: () => context.pushPage(AppPage.user, resourceId: logEntry.user.id),
          ),
        ),
      ],
    );
  }

  String _localizeAction(AppLocalizations locale) {
    final resourceName = logEntry.module.localizedResourceName(locale);
    final localizedAction = logEntry.action.localized(locale).call(
          logEntry.targetEntityId ?? '?',
          resourceName,
        );

    // todo add meaningful descriptive property
    return toBeginningOfSentenceCase(localizedAction)!;
  }

  @override
  Widget build(BuildContext context) {
    const expandedTextStyle = TextStyle(fontSize: 16);
    const splashRadius = 16.0;
    const childrenPadding = EdgeInsets.only(left: 16, right: 16, bottom: 8);

    final locale = context.locale;

    final redirectCallback = _buildRedirectToAffectedResource();
    final (:date, :time) = formatDate(logEntry.createDate);

    return ExpansionTile(
      title: Text.rich(_localizeEntryTitle(context)),
      trailing: logEntry.targetEntityId != null
          ? IconButton(
              onPressed: redirectCallback != null ? () => redirectCallback(context) : null,
              icon: const Icon(Icons.arrow_forward),
              splashRadius: splashRadius,
            )
          : null,
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: childrenPadding,
      children: [
        Text.rich(
          TextSpan(
            style: expandedTextStyle,
            children: [
              TextSpan(text: locale.logEntryCreatedAt),
              TextSpan(text: '$time $date', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            style: expandedTextStyle,
            children: [
              TextSpan(text: locale.logEntryOriginModule),
              TextSpan(
                text: logEntry.module.localizedName(locale),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
