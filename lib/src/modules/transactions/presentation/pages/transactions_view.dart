import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/transaction_controller_provider.dart';
import '../transaction_card.dart';

class TransactionsView extends ConsumerWidget {
  const TransactionsView({super.key});

  // todo query filters and sorting!
  factory TransactionsView.pageBuilder(BuildContext _, GoRouterState state) =>
      const TransactionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final value = ref.watch(transactionControllerProvider);

    return switch (value) {
      AsyncData(value: final transactions) => Wrap(
          runAlignment: WrapAlignment.spaceEvenly,
          children: transactions.data
              .map(
                (t) => ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: size.width / 3 - 10),
                  child: TransactionCard(transaction: t),
                ),
              )
              .toList(growable: false),
        ),
      AsyncError(:final error) => Text('$error'),
      _ => const CircularProgressIndicator(),
    };
  }
}
