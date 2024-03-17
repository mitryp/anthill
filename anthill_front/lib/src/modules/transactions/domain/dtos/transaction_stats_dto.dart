import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_stats_dto.freezed.dart';

part 'transaction_stats_dto.g.dart';

@freezed
class TransactionStatsDto with _$TransactionStatsDto {
  const factory TransactionStatsDto({
    required DateTime fromDate,
    required DateTime toDate,
    required double sum,
    required double average,
    required int count,
    required double largestDonation,
  }) = _TransactionStatsDto;

  factory TransactionStatsDto.fromJson(Map<String, Object?> json) =>
      _$TransactionStatsDtoFromJson(json);
}
