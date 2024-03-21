import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../shared/utils/round_with_precision.dart';
import '../../../shared/utils/widget_list_divide.dart';
import '../domain/dtos/transaction_stats_dto.dart';

class GeneralStatsDiagram extends StatelessWidget {
  final TransactionStatsDto _statsDto;

  const GeneralStatsDiagram({
    required TransactionStatsDto statsDto,
    super.key,
  }) : _statsDto = statsDto;

  @override
  Widget build(BuildContext context) {
    final data = [_statsDto.incomesSum, _statsDto.expensesSum];

    final series = [
      charts.Series<double, double>(
        id: 'Incomes/expenses',
        domainFn: (datum, index) => (index ?? 0.0).toDouble(),
        measureFn: (datum, _) => datum,
        colorFn: (datum, index) => data[index ?? 0] < 0
            ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.green.shadeDefault,
        data: data.map((e) => e.abs()).toList(growable: false),
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        charts.PieChart(series),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatsLabel(name: 'Incomes', value: '${_statsDto.incomesSum.roundWithPrecision()}'),
              _StatsLabel(name: 'Expenses', value: '${_statsDto.expensesSum.roundWithPrecision()}'),
              _StatsLabel(
                name: 'Largest income',
                value: '${_statsDto.largestIncome.roundWithPrecision()}',
              ),
              _StatsLabel(
                name: 'Average income',
                value: '${_statsDto.averageIncome.roundWithPrecision()}',
              ),
            ].divide(const SizedBox(height: 4)),
          ),
        ),
      ].map((e) => Expanded(child: e)).toList(growable: false),
    );
  }
}

class _StatsLabel extends StatelessWidget {
  final String _name;
  final String _value;
  final TextStyle? _nameStyle;
  final TextStyle? _valueStyle;

  const _StatsLabel({
    required String name,
    required String value,
    TextStyle? nameStyle,
    TextStyle? valueStyle,
  })  : _nameStyle = nameStyle,
        _valueStyle = valueStyle,
        _value = value,
        _name = name;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: _nameStyle,
        children: [
          TextSpan(
            text: '$_name: ',
            style: const TextStyle(fontWeight: FontWeight.bold).merge(_nameStyle),
          ),
          TextSpan(text: _value, style: _valueStyle),
        ],
      ),
    );
  }
}