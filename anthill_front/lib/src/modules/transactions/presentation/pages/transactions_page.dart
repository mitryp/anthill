import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/constraints/app_page.dart';
import '../../../../shared/presentation/utils/context_app_pages.dart';
import '../../../../shared/presentation/widgets/copy_link_button.dart';
import '../../../../shared/utils/normalize_query_params.dart';
import '../../../../shared/utils/paginated_collection_view.dart';
import '../../application/providers/transaction_service_provider.dart';
import '../../application/providers/transactions_provider.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../transaction_card.dart';

class TransactionsPage extends StatelessWidget {
  final QueryParams _queryParams;

  const TransactionsPage({QueryParams queryParams = const {}, super.key})
      : _queryParams = queryParams;

  factory TransactionsPage.pageBuilder(BuildContext _, GoRouterState state) {
    final params = state.uri.queryParametersAll.normalize();

    return TransactionsPage(queryParams: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: const [CopyLinkButton()],
      ),
      body: PaginatedCollectionView<TransactionReadDto>(
        queryParams: _queryParams,
        httpServiceProvider: transactionServiceProvider,
        collectionProvider: transactionsProvider,
        viewBuilder: (context, transactions) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.data.length,
            itemBuilder: (context, index) {
              final item = transactions.data[index];

              return TransactionCard(transaction: item);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goPage(AppPage.transactionEditor),
      ),
    );
  }
}
