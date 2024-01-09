import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/application/providers/shareable_url_provider.dart';
import '../../../../shared/utils/normalize_query_params.dart';
import '../transactions_paginated_view.dart';
import '../../../../shared/presentation/constraints/app_page.dart';
import '../../../../shared/presentation/utils/context_app_pages.dart';
import '../../../../shared/presentation/widgets/copy_link_button.dart';

class TransactionsPage extends StatelessWidget {
  final QueryParams _queryParams;

  const TransactionsPage({QueryParams queryParams = const {}, super.key})
      : _queryParams = queryParams;

  factory TransactionsPage.pageBuilder(BuildContext _, GoRouterState state) => TransactionsPage(
        queryParams: state.uri.queryParametersAll.normalize(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          Consumer(
            builder: (context, ref, child) =>
                CopyLinkButton(link: '${ref.watch(shareableUrlProvider)}'),
          ),
        ],
      ),
      body: TransactionsPaginatedView(queryParams: _queryParams),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goPage(AppPage.transactionEditor),
      ),
    );
  }
}
