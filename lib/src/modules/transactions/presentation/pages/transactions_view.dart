import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/dtos/paginated_dto.dart';
import '../../../../shared/presentation/widgets/page_base.dart';
import '../../application/providers/transaction_controller_provider.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../transaction_card.dart';

class TransactionsView extends ConsumerWidget {
  const TransactionsView({super.key});

  // todo query filters and sorting!
  factory TransactionsView.pageBuilder(BuildContext _, GoRouterState state) =>
      const TransactionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final AsyncValue<PaginatedDto<TransactionReadDto>> value =
        ref.watch(transactionControllerProvider);

    return PageBody(
      child: switch (value) {
        AsyncData(value: final transactions) => ListView.builder(
            itemCount: transactions.data.length,
            itemBuilder: (context, index) {
              final item = transactions.data[index];

              return ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: size.width / 3 - 10),
                child: TransactionCard(transaction: item),
              );
            },
          ),
        AsyncError(:final error) => Text('$error'),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
