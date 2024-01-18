import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/dtos/transaction_read_dto.dart';
import 'transaction_service_provider.dart';

part 'transaction_by_id_provider.g.dart';

@riverpod
Future<TransactionReadDto> transactionById(TransactionByIdRef ref, int id) =>
    ref.watch(transactionServiceProvider).getOne(id);
