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
import '../general_stats_diagram.dart';
import '../period_stats_diagram.dart';

class TransactionsStatsPage extends ConsumerWidget {
  final DateTime from;
  final DateTime to;

  const TransactionsStatsPage({required this.from, required this.to, super.key});

  factory TransactionsStatsPage.pageBuilder(BuildContext context, GoRouterState state) {
    late final today = DateTime.now();

    final params = state.uri.queryParameters;
    final (fromStr, toStr) = (params['from'], params['to']);
    final from = (fromStr != null ? deserializeDateQueryParam(fromStr) : null) ?? today;
    final to = (toStr != null ? deserializeDateQueryParam(toStr) : null) ??
        today.add(const Duration(days: 1));

    CopyLinkButton.updateProviderWithParams(
      params: {
        'from': fromStr ?? serializeDateQueryParam(from),
        'to': toStr ?? serializeDateQueryParam(to),
      },
      context: context,
      state: state,
    );

    return TransactionsStatsPage(from: from, to: to);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const diagramPadding = EdgeInsets.all(8.0);
    const diagramHeight = 250.0;
    final diagramDecoration = BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(16),
      color: Colors.grey.shade200,
    );

    final value = ref.watch(transactionStatsProvider(fromDate: from, toDate: to));

    final stateRepr = switchSingleModelValue(value, context: context);
    if (stateRepr != null) {
      return stateRepr;
    }

    final stats = value.requireValue;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stats for '
          '${formatDate(stats.fromDate).date} - ${formatDate(stats.toDate).date}',
        ),
        actions: [CopyLinkButton.fromProvider()],
      ),
      body: PageBody(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: diagramPadding,
                  height: diagramHeight,
                  decoration: diagramDecoration,
                  child: GeneralStatsDiagram(statsDto: stats),
                ),
                if (stats.balances.length > 1)
                  Container(
                    padding: diagramPadding,
                    height: diagramHeight,
                    decoration: diagramDecoration,
                    child: PeriodStatsDiagram(balances: stats.balances),
                  ),
              ].divide(const SizedBox(height: 4)),
            ),
          ),
        ),
      ),
    );
  }
}
