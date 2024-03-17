import '../../../../shared/http.dart';
import '../../../../shared/typedefs.dart';
import '../../../../shared/utils/date_transfer_format.dart';
import '../../domain/dtos/transaction_create_dto.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../../domain/dtos/transaction_stats_dto.dart';

const transactionsResourceName = 'transactions';

class TransactionService extends HttpService<TransactionReadDto>
    with HttpWriteMixin<TransactionReadDto, TransactionCreateDto, TransactionCreateDto> {
  const TransactionService({required super.client})
      : super(decoder: TransactionReadDto.fromJson, apiPrefix: transactionsResourceName);

  Future<TransactionStatsDto> getStats({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final data = await client.get<JsonMap>(
      '$apiPrefix/stats/range',
      queryParameters: {
        'from': serializeDateQueryParam(fromDate),
        'to': serializeDateQueryParam(toDate),
      },
    ).then((res) => res.data);

    if (data == null) {
      throw NoResourceError('TransactionStatsDto');
    }

    return TransactionStatsDto.fromJson(data);
  }
}
