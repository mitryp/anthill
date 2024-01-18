import '../../../../shared/http.dart';
import '../../domain/dtos/transaction_create_dto.dart';
import '../../domain/dtos/transaction_read_dto.dart';

const transactionsResourceName = 'transactions';

class TransactionService extends HttpService<TransactionReadDto>
    with HttpWriteMixin<TransactionReadDto, TransactionCreateDto, TransactionCreateDto> {
  const TransactionService({required super.client})
      : super(decoder: TransactionReadDto.fromJson, apiPrefix: transactionsResourceName);
}
