import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import 'transaction_service_provider.dart';

part 'transaction_by_id_provider.g.dart';

@riverpod
Future<TransactionReadDto> transactionById(
  TransactionByIdRef ref,
  int id, [
  BuildContext? context,
]) =>
    ref.watch(transactionServiceProvider).getOne(id).onError(
          (error, stackTrace) => interceptDioError(error, stackTrace, context: context),
          test: isDioError,
        );
