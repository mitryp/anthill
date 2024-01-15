import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../services/transaction_service.dart';

part 'transaction_service_provider.g.dart';

@riverpod
TransactionService transactionService(TransactionServiceRef ref) {
  final client = ref.watch(httpClientProvider);

  return TransactionService(client: client);
}
