import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../shared/presentation/widgets/copy_link_button.dart';
import '../../../../shared/presentation/widgets/page_body.dart';
import '../../../../shared/presentation/widgets/switch_single_model_value.dart';
import '../../../../shared/utils/date_format.dart';
import '../../../../shared/utils/date_transfer_format.dart';
import '../../../../shared/utils/download_bytes_image.dart';
import '../../../../shared/utils/widget_list_divide.dart';
import '../../application/providers/transaction_stats_provider.dart';
import '../../domain/dtos/transaction_stats_dto.dart';
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

  Future<void> _downloadStats(Widget statsWidget) async {
    final fromStr = serializeDateQueryParam(from);
    final toStr = serializeDateQueryParam(to);

    final bytes = await ScreenshotController().captureFromWidget(
      Material(
        color: Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 456,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Stats for the period from $fromStr to $toStr',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                statsWidget,
              ],
            ),
          ),
        ),
      ),
    );

    downloadBytesImage(
      bytes,
      '$fromStr-$toStr.png',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        actions: [
          IconButton(
            onPressed: () => _downloadStats(
              _StatsDiagrams(statsDto: stats, animate: false),
            ),
            icon: const Icon(Icons.save_alt),
            tooltip: 'Save report image',
          ),
          CopyLinkButton.fromProvider(),
        ],
      ),
      body: PageBody(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: stats.balances.isNotEmpty
              ? SingleChildScrollView(
                  child: _StatsDiagrams(statsDto: stats),
                )
              : const Center(
                  child: Text(
                    'No stats for the selected period :(',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
        ),
      ),
    );
  }
}

class _StatsDiagrams extends StatelessWidget {
  final bool _animate;
  final TransactionStatsDto _statsDto;

  const _StatsDiagrams({
    required TransactionStatsDto statsDto,
    bool animate = true,
  })  : _statsDto = statsDto,
        _animate = animate;

  @override
  Widget build(BuildContext context) {
    const diagramPadding = EdgeInsets.all(8.0);
    const diagramHeight = 250.0;
    final diagramDecoration = BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(16),
      color: Colors.grey.shade200,
    );

    return Column(
      children: [
        Container(
          padding: diagramPadding,
          height: diagramHeight,
          decoration: diagramDecoration,
          child: GeneralStatsDiagram(statsDto: _statsDto, animate: _animate),
        ),
        if (_statsDto.balances.length > 1)
          Container(
            padding: diagramPadding,
            height: diagramHeight,
            decoration: diagramDecoration,
            child: PeriodStatsDiagram(balances: _statsDto.balances, animate: _animate),
          ),
      ].divide(const SizedBox(height: 4)),
    );
  }
}
