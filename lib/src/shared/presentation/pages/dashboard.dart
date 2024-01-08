import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../modules/transactions/presentation/pages/transactions_view.dart';
import '../constraints/app_page.dart';
import '../utils/context_app_pages.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  factory Dashboard.pageBuilder(BuildContext _, GoRouterState __) => const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: const TransactionsPaginatedView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goPage(AppPage.transactionEditor),
      ),
    );
  }
}
