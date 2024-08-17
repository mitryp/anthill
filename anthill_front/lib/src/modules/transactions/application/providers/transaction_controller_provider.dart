// ignore_for_file: avoid_build_context_in_providers
// ignore_for_file: avoid_public_notifier_properties
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../../domain/dtos/transaction_create_dto.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import '../services/transaction_service.dart';
import 'transaction_by_id_provider.dart';
import 'transaction_service_provider.dart';
import 'transaction_source_suggestions_provider.dart';
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

  @override
  Future<TransactionReadDto> updateResource(
    int id,
    TransactionCreateDto dto, [
    BuildContext? context,
  ]) async {
    final updated = await super.updateResource(id, dto, context);

    await _invalidateSuggestionsIfNeeded(updated.sourceOrPurpose);

    return updated;
  }

  @override
  Future<TransactionReadDto> createResource(
    TransactionCreateDto dto, [
    BuildContext? context,
  ]) async {
    final created = await super.createResource(dto, context);

    await _invalidateSuggestionsIfNeeded(created.sourceOrPurpose);

    return created;
  }

  Future<void> _invalidateSuggestionsIfNeeded(String newValue) async {
    final existingSuggestions = await ref.read(transactionSourceSuggestionsProvider.future);

    if (!existingSuggestions.contains(newValue)) {
      ref.invalidate(transactionSourceSuggestionsProvider);
    }
  }
}
