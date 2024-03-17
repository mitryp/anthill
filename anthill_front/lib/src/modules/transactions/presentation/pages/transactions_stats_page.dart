import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/copy_link_button.dart';
import '../../../../shared/presentation/widgets/page_body.dart';
import '../../../../shared/presentation/widgets/switch_single_model_value.dart';
import '../../../../shared/utils/date_format.dart';
import '../../../../shared/utils/date_transfer_format.dart';
import '../../../../shared/utils/widget_list_divide.dart';
import '../../application/providers/transaction_stats_provider.dart';

class TransactionsStatsPage extends ConsumerWidget {
  final DateTime from;
  final DateTime to;

  const TransactionsStatsPage({required this.from, required this.to, super.key});

  factory TransactionsStatsPage.pageBuilder(BuildContext context, GoRouterState state) {
    final params = state.uri.queryParameters;
    final (fromStr, toStr) = (params['from'], params['to']);
    final from = fromStr != null ? deserializeDateQueryParam(fromStr) : null;
    final to = toStr != null ? deserializeDateQueryParam(toStr) : null;

    late final today = DateTime.now();

    return from != null && to != null
        ? TransactionsStatsPage(from: from, to: to)
        : TransactionsStatsPage(from: today, to: today);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(transactionStatsProvider(fromDate: from, toDate: to));

    final stateRepr = switchSingleModelValue(value, context: context);
    if (stateRepr != null) {
      return stateRepr;
    }

    final stats = value.requireValue;
    const labelStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stats for '
          '${formatDate(stats.fromDate).date} - ${formatDate(stats.toDate).date}',
        ),
        actions: const [CopyLinkButton()],
      ),
      body: PageBody(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Total: ', style: labelStyle),
                    TextSpan(text: '${stats.sum.roundWithPrecision()}'),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Transactions: ', style: labelStyle),
                    TextSpan(text: '${stats.count}'),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Average donation: ', style: labelStyle),
                    TextSpan(text: '${stats.average.roundWithPrecision()}'),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Largest donation: ', style: labelStyle),
                    TextSpan(text: '${stats.largestDonation.roundWithPrecision()}'),
                  ],
                ),
              ),
            ].divide(const SizedBox(height: 4)),
          ),
        ),
      ),
    );
  }
}

extension _RoundWithPrecision on double {
  double roundWithPrecision([int digits = 2]) {
    final multiplier = pow(10, digits);

    return (this * multiplier).roundToDouble() / multiplier;
  }
}
