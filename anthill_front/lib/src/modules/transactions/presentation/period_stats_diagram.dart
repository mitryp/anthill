import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

class PeriodStatsDiagram extends StatelessWidget {
  final Map<DateTime, double> _balances;

  const PeriodStatsDiagram({
    required Map<DateTime, double> balances,
    super.key,
  }) : _balances = balances;

  @override
  Widget build(BuildContext context) {
    final entries = _balances.entries.toList(growable: false);

    final seriesList = [
      charts.Series<MapEntry<DateTime, double>, DateTime>(
        id: 'Balances',
        domainFn: (entry, _) => entry.key,
        measureFn: (entry, _) => entry.value,
        data: entries,
      ),
    ];

    return charts.TimeSeriesChart(
      seriesList,
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
      ),
    );
  }
}
