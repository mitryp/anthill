import 'package:flutter/material.dart';

import '../../../shared/presentation/constraints/app_page.dart';
import '../../../shared/presentation/utils/context_app_pages.dart';
import '../../../shared/utils/date_format.dart';
import '../domain/dtos/transaction_read_dto.dart';

class TransactionCard extends StatelessWidget {
  final TransactionReadDto _transaction;

  const TransactionCard({required TransactionReadDto transaction, super.key})
      : _transaction = transaction;

  @override
  Widget build(BuildContext context) {
    final (:date, :time) = formatDate(_transaction.createDate);

    return Card(
      child: ListTile(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: _transaction.sourceOrPurpose),
              const TextSpan(text: ' - '),
              TextSpan(
                text: '${_transaction.amount}GBP',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        subtitle: _transaction.note.isNotEmpty ? Text(_transaction.note) : null,
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(date),
            Text(
              time,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () => context.pushPage(
          AppPage.transaction,
          resourceId: _transaction.id,
          extra: _transaction,
        ),
      ),
    );
  }
}
