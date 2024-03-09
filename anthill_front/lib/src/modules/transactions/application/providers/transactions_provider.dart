import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/http/invalidate_on_error.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import 'transaction_service_provider.dart';

part 'transactions_provider.g.dart';

@riverpod
Future<Paginated<TransactionReadDto>> transactions(TransactionsRef ref, QueryParams params) =>
    ref.watch(transactionServiceProvider).getMany(params).invalidateOnHttpError(ref);
