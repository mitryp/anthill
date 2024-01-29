import 'package:flutter/material.dart';

import '../../../shared/navigation.dart';
import '../../../shared/widgets.dart';
import '../domain/dtos/transaction_read_dto.dart';

class TransactionCard extends StatelessWidget {
  final TransactionReadDto _transaction;

  const TransactionCard({required TransactionReadDto transaction, super.key})
      : _transaction = transaction;

  @override
  Widget build(BuildContext context) {
    return ResourceCard(
      model: _transaction,
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${_transaction.amount}GBP',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ': '),
            TextSpan(text: _transaction.sourceOrPurpose),
          ],
        ),
      ),
      subtitle: _transaction.note.isNotEmpty ? Text(_transaction.note) : null,
      onTap: () => context.pushPage(
        AppPage.transaction,
        resourceId: _transaction.id,
      ),
    );
  }
}
