import 'package:flutter/material.dart';

import '../../modules/transactions/presentation/transactions_view.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: const TransactionsView(),
    );
  }
}
