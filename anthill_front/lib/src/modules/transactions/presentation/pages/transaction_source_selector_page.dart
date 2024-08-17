import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/navigation.dart';
import '../../../../shared/widgets.dart';
import '../../application/providers/transaction_source_suggestions_provider.dart';

class TransactionSourceSelectorPage extends ConsumerStatefulWidget {
  final String? selection;

  const TransactionSourceSelectorPage({this.selection, super.key});

  static Widget pageBuilder(BuildContext context, GoRouterState state) {
    final extra = state.extra;
    final selection = extra is String ? extra : null;

    return TransactionSourceSelectorPage(selection: selection);
  }

  @override
  ConsumerState<TransactionSourceSelectorPage> createState() =>
      _TransactionSourceSelectorPageState();
}

class _TransactionSourceSelectorPageState extends ConsumerState<TransactionSourceSelectorPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suggestionsValue = ref.watch(transactionSourceSuggestionsProvider);

    final intermediateRes = suggestionsValue.whenOrNull(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorNotice(error: error),
    );

    Set<String> buildSuggestions() {
      final value = suggestionsValue.requireValue;
      final selection = widget.selection;

      return {
        if (selection != null && selection.isNotEmpty && !value.contains(selection)) selection,
        ...value,
      };
    }

    late final rawSuggestions = buildSuggestions();

    final locale = context.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.sourceSelectorTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(transactionSourceSuggestionsProvider),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: PageBody(
          child: intermediateRes ??
              Column(
                children: [
                  SearchBar(
                    controller: _searchController,
                    hintText: locale.sourceSelectorSearchHint,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListenableBuilder(
                      listenable: _searchController,
                      builder: (context, _) {
                        final query = _searchController.text.trim().toLowerCase();
                        final filtered = rawSuggestions
                            .where((e) => e.trim().toLowerCase().contains(query))
                            .toList(growable: false);
                        final proposedValue = _searchController.text.trim();
                        final showCreateButton = query.isNotEmpty &&
                            !rawSuggestions.map((e) => e.trim().toLowerCase()).contains(query);

                        final suggestions = [
                          ...filtered,
                          if (showCreateButton) proposedValue,
                        ];

                        return ListView.builder(
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            final item = suggestions[index];

                            return _SuggestionTile(
                              value: item,
                              selected: widget.selection == item,
                              suggestedToCreate: showCreateButton && proposedValue == item,
                              key: ValueKey('$item ${proposedValue == item}'),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  final String value;
  final bool selected;
  final bool suggestedToCreate;

  const _SuggestionTile({
    required this.value,
    this.selected = false,
    this.suggestedToCreate = false,
    super.key,
  });

  void _onTap(BuildContext context) => context.pop(value.trim());

  @override
  Widget build(BuildContext context) {
    if (suggestedToCreate) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton.icon(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 24)),
          ),
          icon: const Icon(Icons.add),
          onPressed: () => _onTap(context),
          label: Text(context.locale.sourceSelectorCreateValueLabel(value)),
        ),
      );
    }

    return ListTile(
      title: Text(value),
      selected: selected,
      onTap: () => _onTap(context),
      leading: selected ? const Icon(Icons.check) : null,
    );
  }
}

Future<String?> showTransactionSourceSuggestions(
  BuildContext context, [
  String? selection,
]) =>
    context.pushPage<String>(
      AppPage.transactionsSourceSelector,
      extra: selection,
    );
