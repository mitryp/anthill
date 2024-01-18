// ignore_for_file: avoid_public_notifier_properties
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../../domain/dtos/transaction_create_dto.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../services/transaction_service.dart';
import 'transaction_by_id_provider.dart';
import 'transaction_service_provider.dart';
import 'transactions_provider.dart';

part 'transaction_controller_provider.g.dart';

@riverpod
class TransactionController extends _$TransactionController
    with
        CollectionControllerMixin<TransactionReadDto, TransactionCreateDto, TransactionCreateDto,
            TransactionService> {
  @override
  ProviderBase<TransactionService> get serviceProvider => transactionServiceProvider;

  @override
  ProviderOrFamily get collectionProvider => transactionsProvider;

  @override
  ProviderOrFamily Function(int id) get resourceByIdProvider => transactionByIdProvider;

  @override
  FutureOr<void> build() {}
}
