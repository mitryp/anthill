import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/providers/transactions_provider.dart';
import 'transaction_card.dart';

class TransactionsView extends ConsumerWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final value = ref.watch(transactionsProvider);

    final child = switch (value) {
      AsyncData(value: final transactions) => Wrap(
          runAlignment: WrapAlignment.spaceEvenly,
          children: transactions
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

    return child;
  }
}
