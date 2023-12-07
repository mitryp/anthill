import 'package:flutter/material.dart';

import '../domain/dtos/transaction_read_dto.dart';
import 'transaction_view.dart';

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
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TransactionView(transaction: _transaction)),
        ),
      ),
    );
  }
}
