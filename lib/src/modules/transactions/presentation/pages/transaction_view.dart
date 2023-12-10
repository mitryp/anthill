import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/constraints/app_page.dart';
import '../../../../shared/presentation/dialogs/confirmation_dialog.dart';
import '../../../../shared/presentation/utils/context_app_pages.dart';
import '../../../../shared/presentation/widgets/copy_link_button.dart';
import '../../../../shared/presentation/widgets/error_notice.dart';
import '../../application/providers/transaction_controller_provider.dart';
import '../../application/providers/transaction_provider.dart';
import '../../domain/dtos/transaction_read_dto.dart';

class TransactionView extends ConsumerWidget {
  final int _transactionId;
  final TransactionReadDto? _transaction;

  const TransactionView({required int transactionId, TransactionReadDto? transaction, super.key})
      : _transactionId = transactionId,
        _transaction = transaction;

  factory TransactionView.pageBuilder(BuildContext context, GoRouterState state) {
    final idStr = state.pathParameters['id'];
    final extra = state.extra;
    final passedTransaction = extra is TransactionReadDto ? extra : null;
    final id = (idStr != null ? int.tryParse(idStr) : null) ?? passedTransaction?.id;

    if (id == null) {
      throw StateError('transaction id was not correct');
    }

    return TransactionView(
      transactionId: id,
      transaction: passedTransaction,
    );
  }

  Future<void> _deleteTransaction(
    BuildContext context,
    WidgetRef ref,
    TransactionReadDto transaction,
  ) async {
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
        .deleteResource(transaction.id, context);

    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passedTransaction = _transaction;
    final transactionId = _transactionId;

    final value = passedTransaction != null
        ? AsyncData(passedTransaction)
        : ref.watch(transactionByIdProvider(transactionId));

    switch (value) {
      case AsyncError(:final error):
        return ErrorNotice(error: error, withScaffold: true);
      case AsyncLoading():
        return Scaffold(
          appBar: AppBar(title: const Text('Loading')),
          body: const Center(child: CircularProgressIndicator()),
        );
    }

    final transaction = value.requireValue;

    final child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: ListTile(
            title: Text('Transaction: ${transaction.sourceOrPurpose}'),
            subtitle: transaction.note.isNotEmpty ? Text(transaction.note) : null,
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
                label: Text('${transaction.amount}'),
                backgroundColor: transaction.isIncome ? Colors.green[300] : Colors.redAccent[100],
              ),
              Chip(label: Text('${transaction.createDate}')),
              if (transaction.deleteDate != null) Chip(label: Text('${transaction.deleteDate}')),
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
            onPressed: () => _deleteTransaction(context, ref, transaction),
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.red[400])),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => context.goPage(AppPage.transactionEditor, extra: _transaction),
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
        ),
      ],
    );

    final currentPath = GoRouterState.of(context).uri;

    return Scaffold(
      appBar: AppBar(
        actions: [CopyLinkButton(link: '$currentPath')],
      ),
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
