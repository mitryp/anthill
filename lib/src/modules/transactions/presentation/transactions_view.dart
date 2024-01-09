import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/presentation/widgets/error_notice.dart';
import '../../../shared/presentation/widgets/page_base.dart';
import '../../../shared/presentation/widgets/riverpod_paginated_view.dart';
import '../../../shared/utils/restore_pagination_controller.dart';
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

class _TransactionsPaginatedViewState extends ConsumerState<TransactionsPaginatedView> {
  static late final PaginateConfig _transactionsConfig;
  static bool _isConfigLoaded = false;

  late final PaginationController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    if (_isConfigLoaded) {
      _initController();
    } else {
      ref.read(transactionServiceProvider).getPaginateConfig().then((config) {
        if (!_isConfigLoaded) {
          _transactionsConfig = config;
          _isConfigLoaded = true;
        }
        _initController();
      });
    }
  }

  Future<void> _initController() async {
    if (!mounted) return;

    _controller = restoreController(
      widget._queryParams,
      paginateConfig: _transactionsConfig,
    );

    setState(() => _isInitialized = true);
  }

  @override
  Widget build(BuildContext context) {
    const loadingIndicator = CircularProgressIndicator();

    if (!_isInitialized) {
      return loadingIndicator;
    }

    return PageBody(
      child: Column(
        children: [
          RiverpodPaginatedView(
            controller: _controller,
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
            errorBuilder: (context, error) => ErrorNotice(error: error),
            loadingIndicator: (context) => loadingIndicator,
          ),
        ],
      ),
    );
  }
}
