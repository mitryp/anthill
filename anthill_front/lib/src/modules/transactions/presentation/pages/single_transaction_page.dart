import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/http.dart';
import '../../../../shared/navigation.dart';
import '../../../../shared/widgets.dart';
import '../../../auth/application/providers/auth_provider.dart';
import '../../../users/users_module.dart';
import '../../application/providers/transaction_by_id_provider.dart';
import '../../application/providers/transaction_controller_provider.dart';
import '../../domain/dtos/transaction_read_dto.dart';

class SingleTransactionPage extends ConsumerWidget with CanControlCollection<TransactionReadDto> {
  final int _transactionId;

  const SingleTransactionPage({
    required int transactionId,
    super.key,
  }) : _transactionId = transactionId;

  factory SingleTransactionPage.pageBuilder(BuildContext context, GoRouterState state) {
    final (:id, model: _) = modelFromRouterState<TransactionReadDto>(state);

    return SingleTransactionPage(transactionId: id);
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
    final provider = transactionByIdProvider(_transactionId);
    Future<void> waitUntilInvalidated() async {
      if (!context.mounted) return;
      return ref.read(provider.future);
    }

    final value = ref.watch(provider);

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
      onEditPressed: isDeleted
          ? null
          : () => openEditor(context, transaction).whenComplete(waitUntilInvalidated),
      onDeletePressed: isDeleted
          ? null
          : () => deleteModel(context, ref, transaction).whenComplete(waitUntilInvalidated),
      onRestorePressed: !isDeleted
          ? null
          : () => restoreModel(context, ref, transaction).whenComplete(waitUntilInvalidated),
      showRestoreButton: ref.watch(authProvider).value?.role == UserRole.admin,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [CopyLinkButton(link: '${GoRouterState.of(context).uri}')],
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
