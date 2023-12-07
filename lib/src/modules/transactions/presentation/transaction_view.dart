import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/presentation/dialogs/confirmation_dialog.dart';
import '../../../shared/presentation/exception_interceptor.dart';
import '../application/providers/transaction_controller_provider.dart';
import '../domain/dtos/transaction_read_dto.dart';

class TransactionView extends StatelessWidget {
  final TransactionReadDto _transaction;

  const TransactionView({required TransactionReadDto transaction, super.key})
      : _transaction = transaction;

  @override
  Widget build(BuildContext context) {
    final col = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: ListTile(
            title: Text('Transaction: ${_transaction.sourceOrPurpose}'),
            subtitle: _transaction.note.isNotEmpty ? Text(_transaction.note) : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: OverflowBar(
            alignment: MainAxisAlignment.start,
            spacing: 8,
            overflowSpacing: 8,
            children: [
              Chip(
                label: Text('${_transaction.amount}'),
                backgroundColor: _transaction.isIncome ? Colors.green[300] : Colors.redAccent[100],
              ),
              Chip(label: Text('${_transaction.createDate}')),
              if (_transaction.deleteDate != null) Chip(label: Text('${_transaction.deleteDate}')),
            ],
          ),
        ),
      ],
    );

    final controls = OverflowBar(
      alignment: MainAxisAlignment.spaceAround,
      children: [
        Consumer(
          builder: (context, ref, child) => OutlinedButton.icon(
            onPressed: () async {
              if (!await askUserConfirmation(
                    context,
                    const Text('Do you really want to delete this transaction?'),
                  ) ||
                  !context.mounted) {
                return;
              }

              // ignore: use_build_context_synchronously
              await ref
                  .read(transactionControllerProvider.notifier)
                  .deleteTransaction(_transaction.id, context);

              if (context.mounted) {
                context.pop();
              }
            },
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.red[400])),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
        ),
      ],
    );

    final child = col;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: constraints.widthConstraints() / 2.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child,
                const SizedBox(height: 32),
                controls,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
