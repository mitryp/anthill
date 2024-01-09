import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/application/http/http_service.dart';
import '../../../shared/presentation/utils/has_pagination_controller_mixin.dart';
import '../../../shared/presentation/widgets/error_notice.dart';
import '../../../shared/presentation/widgets/page_base.dart';
import '../../../shared/presentation/widgets/pagination_controls.dart';
import '../../../shared/presentation/widgets/riverpod_paginated_view.dart';
import '../../../shared/presentation/widgets/single_sort_selector.dart';
import '../application/providers/transaction_service_provider.dart';
import '../application/providers/transactions_provider.dart';
import 'transaction_card.dart';

class TransactionsPaginatedView extends ConsumerStatefulWidget {
  final QueryParams _queryParams;

  const TransactionsPaginatedView({
    QueryParams queryParams = const {},
    super.key,
  }) : _queryParams = queryParams;

  @override
  ConsumerState<TransactionsPaginatedView> createState() => _TransactionsPaginatedViewState();
}

class _TransactionsPaginatedViewState extends ConsumerState<TransactionsPaginatedView>
    with HasPaginationController {
  /// A metadata cache for pagination controls.
  PaginatedMetadata? _meta;

  /// A flag to lock the pagination controls during the requests.
  bool _areControlsLocked = true;

  @override
  ProviderBase<HttpService> get httpServiceProvider => transactionServiceProvider;

  @override
  QueryParams get queryParams => widget._queryParams;

  @override
  Widget build(BuildContext context) {
    const loadingIndicator = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator()],
    );

    if (!isControllerInitialized) {
      return loadingIndicator;
    }

    final meta = _meta;

    return PageBody(
      child: Column(
        children: [
          SingleSortSelector(
            controller: controller,
            isLocked: _areControlsLocked,
          ),
          RiverpodPaginatedView(
            controller: controller,
            collectionProvider: transactionsProvider,
            onDataLoaded: (value) {
              if (!mounted) return;

              setState(() {
                _meta = value.meta;
                _areControlsLocked = false;
              });
            },
            onUpdateRequest: () {
              if (!_areControlsLocked) {
                setState(() => _areControlsLocked = true);
              }
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
            errorBuilder: (context, error) => ErrorNotice(error: error),
            loadingIndicator: (context) => loadingIndicator,
          ),
          if (meta != null)
            PaginationControls.fromMetadata(meta, isLocked: _areControlsLocked).bind(controller),
        ],
      ),
    );
  }
}
