import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/navigation.dart';
import '../../../../shared/pagination.dart';
import '../../../../shared/presentation/widgets/date_range_filter.dart';
import '../../../../shared/presentation/widgets/page_title.dart';
import '../../../../shared/widgets.dart';
import '../../../users/users_module.dart';
import '../../application/providers/transaction_service_provider.dart';
import '../../application/providers/transactions_provider.dart';
import '../../application/services/transaction_service.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../transaction_card.dart';

class TransactionsPage extends StatelessWidget {
  final QueryParams _queryParams;

  const TransactionsPage({QueryParams queryParams = const {}, super.key})
      : _queryParams = queryParams;

  static Widget pageBuilder(BuildContext _, GoRouterState state) {
    final params = state.uri.queryParametersAll.normalize();

    return PageTitle(
      title: 'Transactions',
      child: TransactionsPage(queryParams: params),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [CopyLinkButton.fromProvider()],
      ),
      body: PageBody(
        child: PaginatedCollectionView<TransactionReadDto>(
          queryParams: _queryParams,
          httpServiceProvider: transactionServiceProvider,
          collectionProvider: transactionsProvider,
          collectionName: transactionsResourceName,
          additionalFiltersBuilder: (controller) => Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...[
                ifHasRoles(
                  context,
                  roles: const {UserRole.admin},
                  then: DeleteFilter(controller: controller),
                ),
              ].nonNulls,
              DateRangeFilter(controller: controller),
              IconButton(
                tooltip: 'Stats for '
                    '${controller.filters['createDate'] == null ? 'today' : 'selection'}',
                icon: const Icon(Icons.query_stats),
                iconSize: 24,
                splashRadius: 24,
                onPressed: () {
                  final baseLocation = AppPage.transactionsStats.location;

                  final range = controller.extractDateRange(byKey: 'createDate');
                  final location = range == null
                      ? baseLocation
                      : '$baseLocation?from=${serializeDateQueryParam(
                          range.start,
                        )}&to=${serializeDateQueryParam(range.end)}';

                  context
                      .push(location)
                      .whenComplete(() => controller.silently(notifyAfter: true, (_) {}));
                },
              ),
            ],
          ),
          initialFilters: {
            'deleteDate': {const Null()},
          },
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.pushPage(AppPage.transactionEditor),
      ),
    );
  }
}
