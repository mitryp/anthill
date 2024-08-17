import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'transaction_service_provider.dart';

part 'transaction_source_suggestions_provider.g.dart';

@riverpod
Future<ISet<String>> transactionSourceSuggestions(TransactionSourceSuggestionsRef ref) async {
  final service = ref.watch(transactionServiceProvider);
  final suggestions = await service.getSuggestions();

  ref.keepAlive();

  return suggestions;
}
