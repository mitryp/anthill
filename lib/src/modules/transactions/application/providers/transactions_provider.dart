import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/dtos/transaction_read_dto.dart';
import 'transaction_service_provider.dart';

part 'transactions_provider.g.dart';

@riverpod
Future<List<TransactionReadDto>> transactions(TransactionsRef ref) async {
  final service = ref.watch(transactionServiceProvider);

  return service.getMany();
}
