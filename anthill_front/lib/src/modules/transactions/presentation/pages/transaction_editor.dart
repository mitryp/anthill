import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/page_title.dart';
import '../../../../shared/widgets.dart';
import '../../application/providers/transaction_controller_provider.dart';
import '../../domain/dtos/transaction_create_dto.dart';
import '../../domain/dtos/transaction_read_dto.dart';
import 'transaction_source_selector_page.dart';

class TransactionEditor extends ConsumerStatefulWidget {
  final TransactionReadDto? _readDto;

  const TransactionEditor({TransactionReadDto? transactionToEdit, super.key})
      : _readDto = transactionToEdit;

  static Widget pageBuilder(BuildContext context, GoRouterState state) {
    final extra = state.extra;
    final toEdit = extra is TransactionReadDto ? extra : null;

    final locale = context.locale;

    return PageTitle(
      title: toEdit != null
          ? locale.pageTitleTransactionEditorEdit
          : locale.pageTitleTransactionEditorCreate,
      child: TransactionEditor(transactionToEdit: toEdit),
    );
  }

  @override
  ConsumerState<TransactionEditor> createState() => _TransactionEditorState();
}

class _TransactionEditorState extends ConsumerState<TransactionEditor> {
  late TransactionCreateDto _dto = widget._readDto?.toCreateDto() ??
      const TransactionCreateDto(amount: 0, isIncome: true, sourceOrPurpose: '');
  late final TextEditingController _sourceController =
      TextEditingController(text: _dto.sourceOrPurpose);

  @override
  void dispose() {
    _sourceController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  // todo advanced controls
  void _onAmountChanged(String value, {bool isAdvanced = false}) {
    final amount = double.tryParse(value);

    if (amount == null) {
      return;
    }

    final isIncome = isAdvanced ? _dto.isIncome : amount > 0;

    setState(() {
      _dto = _dto.copyWith(
        amount: amount,
        isIncome: isIncome,
      );
    });
  }

  Future<void> _onSelectSource(String? current) async {
    final value = await showTransactionSourceSuggestions(context, current) //
        .then((value) => value?.trim());

    if (value == null) {
      return;
    }

    _sourceController.text = value;

    setState(() {
      _dto = _dto.copyWith(sourceOrPurpose: value);
    });
  }

  void _onNoteChanged(String value) => setState(() => _dto = _dto.copyWith(note: value));

  Future<void> _saveTransaction() async {
    if (!(_formKey.currentState?.validate() ?? true)) {
      return;
    }
    final existingTransaction = widget._readDto;
    final isEditing = existingTransaction != null;

    final controller = ref.read(transactionControllerProvider.notifier);

    if (isEditing) {
      await controller.updateResource(existingTransaction.id, _dto, context);
    } else {
      await controller.createResource(_dto, context);
    }

    if (mounted && context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TransactionCreateDto(:amount, :sourceOrPurpose, :isIncome, :note) = _dto;
    final size = MediaQuery.of(context).size;

    final locale = context.locale;

    final amountLabel = switch (amount) {
      > 0.0 when isIncome => locale.transactionEditorIncomeLabel,
      < 0.0 when !isIncome => locale.transactionEditorExpenseLabel,
      _ => locale.transactionEditorAmountLabel,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.transactionEditorTitle),
      ),
      floatingActionButton: ProgressIndicatorButton.icon(
        iconButtonBuilder: ElevatedButton.icon,
        onPressed: _saveTransaction,
        icon: const Icon(Icons.save),
        label: Text(locale.saveButtonLabel),
      ),
      body: PageBody(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Padding(
              padding: defaultFormPadding,
              child: SizedBox(
                height: size.height * formHeightFraction,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: amount == 0,
                      validator: isAmount(context),
                      initialValue: amount != 0 ? '$amount' : null,
                      onChanged: _onAmountChanged,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[-\d.]')),
                      ],
                      decoration: InputDecoration(
                        labelText: amountLabel,
                        suffixText: locale.transactionEditorCurrencyName,
                        hintText: '${_dto.amount}',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                    ),
                    InkWell(
                      onTap: () => _onSelectSource(sourceOrPurpose),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _sourceController,
                          validator: isRequired(context),
                          decoration: InputDecoration(
                            labelText: isIncome
                                ? locale.transactionEditorSourceLabel
                                : locale.transactionEditorPurposeLabel,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: note,
                      onChanged: _onNoteChanged,
                      decoration: InputDecoration(
                        labelText: locale.transactionEditorNoteLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on TransactionReadDto {
  TransactionCreateDto toCreateDto() => TransactionCreateDto(
        amount: amount,
        isIncome: isIncome,
        sourceOrPurpose: sourceOrPurpose,
        note: note,
      );
}
