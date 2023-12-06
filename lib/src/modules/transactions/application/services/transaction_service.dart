import '../../../../shared/application/http/http_service.dart';
import '../../domain/dtos/transaction_read_dto.dart';

class TransactionService extends HttpService<TransactionReadDto> {
  const TransactionService({required super.client})
      : super(decoder: TransactionReadDto.fromJson, apiPrefix: 'transactions');
}
