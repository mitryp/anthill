import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/http.dart';
import '../../../../shared/navigation.dart';
import '../../../../shared/widgets.dart';
import '../../application/providers/transaction_by_id_provider.dart';
import '../../application/providers/transaction_controller_provider.dart';
import '../../domain/dtos/transaction_read_dto.dart';

class SingleTransactionPage extends ConsumerWidget with CanControlCollection<TransactionReadDto> {
  final int _transactionId;
  final TransactionReadDto? _transaction;

  const SingleTransactionPage({
    required int transactionId,
    TransactionReadDto? transaction,
    super.key,
  })  : _transactionId = transactionId,
        _transaction = transaction;

  factory SingleTransactionPage.pageBuilder(BuildContext context, GoRouterState state) {
    final (:id, :model) = modelFromRouterState<TransactionReadDto>(state);

    return SingleTransactionPage(
      transactionId: id,
      transaction: model,
    );
  }

  @override
  ProviderListenable<
      CollectionControllerMixin<TransactionReadDto, Model, Model,
          HttpWriteMixin<TransactionReadDto, Model, Model>>> get collectionControllerProvider =>
      transactionControllerProvider.notifier;

  @override
  AppPage get editorPage => AppPage.transactionEditor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passedTransaction = _transaction;
    final transactionId = _transactionId;

    final value = passedTransaction != null
        ? AsyncData(passedTransaction)
        : ref.watch(transactionByIdProvider(transactionId));

    final stateRepr = switchSingleModelValue(value, context: context);
    if (stateRepr != null) {
      return stateRepr;
    }

    final transaction = value.requireValue;
    final (:date, :time) = formatDate(transaction.createDate);

    final child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: ListTile(
            title: Text('Transaction: ${transaction.sourceOrPurpose}'),
            subtitle: transaction.note.isNotEmpty ? Text(transaction.note) : null,
          ),
        ),
        ModelInfoChips(
          children: [
            Chip(
              label: Text(
                '${transaction.amount}GBP',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: transaction.isIncome ? Colors.green[300] : Colors.redAccent[100],
            ),
            Chip(label: Text('$time $date')),
            Chip(
              label: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Created by '),
                    TextSpan(
                      text: transaction.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: transaction.user.isDeleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (transaction.deleteDate != null)
              Chip(
                label: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Deleted at '),
                      TextSpan(text: '${transaction.deleteDate}'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );

    final isDeleted = transaction.isDeleted;

    final controls = SingleModelControls(
      onDeletePressed: isDeleted ? null : () => deleteModel(context, ref, transaction),
      onEditPressed: isDeleted ? null : () => openEditor(context, transaction),
    );

    return Scaffold(
      appBar: AppBar(
        actions: const [CopyLinkButton()],
      ),
      body: PageBody(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
    );
  }
}
