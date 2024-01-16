import 'package:flutter/material.dart';

import '../../../shared/navigation.dart';
import '../../../shared/presentation/widgets/snack_bar_content.dart';
import '../../../shared/utils/date_format.dart';
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
          showSnackBar(
            context,
            title: Text('Missing resource link: ${logEntry.resourceAffected}'),
            subtitle: const Text('Please, report this to the support'),
            backgroundColor: Colors.red.shade200,
          );
        }

        return;
      }

      context.pushPage(targetPage, resourceId: logEntry.targetEntityId);
    };
  }

  TextSpan _localizeEntryTitle(BuildContext context) {
    // todo localization
    return TextSpan(
      children: [
        TextSpan(text: '${_localizeAction(context)} by '),
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

  String _localizeAction(BuildContext context) {
    const actionToRepr = {
      'deleteUser': 'User {} deleted',
      'createUser': 'User {} created',
      'updateUser': 'User {} updated',
      'deleteTransaction': 'Transaction {} deleted',
      'createTransaction': 'Transaction {} created',
      'updateTransaction': 'Transaction {} updated',
    };

    final repr = actionToRepr[logEntry.action];

    return repr?.replaceFirst('{}', '${logEntry.targetEntityId}') ??
        '${logEntry.action} ${logEntry.targetEntityId}';
  }

  @override
  Widget build(BuildContext context) {
    const expandedTextStyle = TextStyle(fontSize: 16);
    const splashRadius = 16.0;
    const childrenPadding = EdgeInsets.only(left: 16, right: 16, bottom: 8);

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
              const TextSpan(text: 'At '),
              TextSpan(text: '$time $date', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            style: expandedTextStyle,
            children: [
              const TextSpan(text: 'Module: '),
              TextSpan(
                text: logEntry.moduleName,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
