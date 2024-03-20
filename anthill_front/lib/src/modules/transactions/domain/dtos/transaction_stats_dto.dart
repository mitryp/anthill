import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_transfer_format.dart';

part 'transaction_stats_dto.freezed.dart';

part 'transaction_stats_dto.g.dart';

@freezed
class TransactionStatsDto with _$TransactionStatsDto {
  const factory TransactionStatsDto({
    required DateTime fromDate,
    required DateTime toDate,
    required double largestIncome,
    required double averageIncome,
    required double incomesSum,
    required int incomesCount,
    required double expensesSum,
    required int expensesCount,
    @JsonKey(fromJson: _balancesFromJson) required Map<DateTime, List<double>> balances,
  }) = _TransactionStatsDto;

  factory TransactionStatsDto.fromJson(Map<String, Object?> json) =>
      _$TransactionStatsDtoFromJson(json);
}

Map<DateTime, List<double>> _balancesFromJson(Map<String, dynamic> json) {
  return json.map((key, value) {
    final dateKey = deserializeDateQueryParam(key)!;

    return MapEntry(dateKey, value as List<double>);
  });
}
