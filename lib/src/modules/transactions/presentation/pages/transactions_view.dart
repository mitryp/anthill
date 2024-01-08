import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/page_base.dart';
import '../../application/providers/transaction_controller_provider.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../transaction_card.dart';

class TransactionsPaginatedView extends ConsumerStatefulWidget {

  const TransactionsPaginatedView({super.key});

  // todo query filters and sorting!
  factory TransactionsPaginatedView.pageBuilder(BuildContext _, GoRouterState state) {
    return TransactionsPaginatedView();
  }

  @override
  ConsumerState<TransactionsPaginatedView> createState() => _TransactionsPaginatedViewState();
}

class _TransactionsPaginatedViewState extends ConsumerState<TransactionsPaginatedView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final AsyncValue<Paginated<TransactionReadDto>> value =
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
