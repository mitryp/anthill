// ignore_for_file: unnecessary_overrides

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/http/collection_controller_mixin.dart';
import '../../../../shared/domain/dtos/paginated_dto.dart';
import '../../domain/dtos/transaction_create_dto.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../services/transaction_service.dart';
import 'transaction_provider.dart';
import 'transaction_service_provider.dart';

part 'transaction_controller_provider.g.dart';

@riverpod
class TransactionController extends _$TransactionController
    with
        CollectionControllerMixin<TransactionReadDto, TransactionService>,
        ModifiableCollectionControllerMixin<TransactionReadDto, TransactionCreateDto,
            TransactionCreateDto, TransactionService> {
  @override
  ProviderBase<TransactionService> get serviceProvider => transactionServiceProvider;

  @override
  void invalidateSingleResourceProviderWithId(int id) =>
      ref.invalidate(transactionByIdProvider(id));

  @override
  Future<PaginatedDto<TransactionReadDto>> build() => super.build();
}
