import 'package:flutter/material.dart';

import '../../../shared/presentation/constraints/app_page.dart';
import '../../../shared/presentation/utils/context_app_pages.dart';
import '../domain/dtos/transaction_read_dto.dart';

class TransactionCard extends StatelessWidget {
  final TransactionReadDto _transaction;

  const TransactionCard({required TransactionReadDto transaction, super.key})
      : _transaction = transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_transaction.sourceOrPurpose),
        subtitle: _transaction.note.isNotEmpty ? Text(_transaction.note) : null,
        trailing: Text('${_transaction.amount}GBP'),
        onTap: () => context.pushPage(
          AppPage.transaction,
          resourceId: _transaction.id,
          extra: _transaction,
        ),
      ),
    );
  }
}
