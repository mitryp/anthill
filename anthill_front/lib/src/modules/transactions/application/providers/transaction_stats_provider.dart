import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/http/invalidate_on_error.dart';
import '../../domain/dtos/transaction_stats_dto.dart';
import 'transaction_service_provider.dart';

part 'transaction_stats_provider.g.dart';

@riverpod
Future<TransactionStatsDto> transactionStats(
  TransactionStatsRef ref, {
  required DateTime fromDate,
  required DateTime toDate,
}) =>
    ref
        .watch(transactionServiceProvider)
        .getStats(fromDate: fromDate, toDate: toDate)
        .invalidateOnHttpError(ref);
