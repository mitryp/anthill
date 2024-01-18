import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/dtos/transaction_read_dto.dart';
import 'transaction_service_provider.dart';

part 'transaction_by_id_provider.g.dart';

@Riverpod(keepAlive: true)
Future<TransactionReadDto> transactionById(TransactionByIdRef ref, int id) =>
    ref.read(transactionServiceProvider).getOne(id);
