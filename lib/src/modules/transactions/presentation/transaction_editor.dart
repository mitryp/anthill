import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/presentation/constraints/app_page.dart';
import '../../../shared/presentation/utils/context_app_pages.dart';
import '../../../shared/utils/validators.dart';
import '../application/providers/transaction_controller_provider.dart';
import '../application/providers/transaction_service_provider.dart';
import '../domain/dtos/transaction_create_dto.dart';
import '../domain/dtos/transaction_read_dto.dart';

class TransactionEditor extends ConsumerStatefulWidget {
  final TransactionReadDto? _readDto;

  const TransactionEditor({TransactionReadDto? transactionToEdit, super.key})
      : _readDto = transactionToEdit;

  factory TransactionEditor.pageBuilder(BuildContext context, GoRouterState state) {
    final extra = state.extra;
    final toEdit = extra is TransactionReadDto ? extra : null;

    return TransactionEditor(transactionToEdit: toEdit);
  }

  @override
  ConsumerState<TransactionEditor> createState() => _TransactionEditorState();
}

class _TransactionEditorState extends ConsumerState<TransactionEditor> {
  late TransactionCreateDto _dto = widget._readDto?.toCreateDto() ??
      const TransactionCreateDto(amount: 0, isIncome: true, sourceOrPurpose: '');

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

  void _onSourceOrPurposeChanged(String value) {
    if (value.isEmpty) {
      return;
    }

    setState(() => _dto = _dto.copyWith(sourceOrPurpose: value));
  }

  void _onNoteChanged(String value) => setState(() => _dto = _dto.copyWith(note: value));

  Future<void> _saveTransaction() async {
    if (!(_formKey.currentState?.validate() ?? true)) {
      return;
    }
    final existingTransaction = widget._readDto;

    final controller = ref.read(transactionControllerProvider.notifier);

    if (existingTransaction == null) {
      await controller.createTransaction(_dto, context);
    } else {
      await controller.updateTransaction(existingTransaction.id, _dto, context);
    }

    ref.invalidate(transactionControllerProvider);

    if (!mounted) {
      return;
    }

    context.goPage(defaultPage);
  }

  @override
  Widget build(BuildContext context) {
    final TransactionCreateDto(:amount, :sourceOrPurpose, :isIncome, :note) = _dto;
    final size = MediaQuery.of(context).size;

    const formHeightFraction = 0.85;
    const maxFormWidthFraction = 0.5;
    const minFromWidth = 300.0;
    const verticalFormPadding = 6.0;
    const horizontalFormPadding = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing transaction'),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: _saveTransaction,
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: min(minFromWidth, size.width),
            maxWidth: size.width * maxFormWidthFraction,
          ).normalize(),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalFormPadding,
                  vertical: verticalFormPadding,
                ),
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
                          labelText: amount == 0
                              ? 'Amount'
                              : 'Amount (${isIncome ? 'income' : 'expense'})',
                          suffixText: 'GBP',
                          hintText: '${_dto.amount}',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ),
                      TextFormField(
                        initialValue: sourceOrPurpose,
                        validator: isRequired(context),
                        onChanged: _onSourceOrPurposeChanged,
                        decoration: InputDecoration(
                          labelText: isIncome ? 'Source' : 'Purpose',
                        ),
                      ),
                      TextFormField(
                        initialValue: note,
                        onChanged: _onNoteChanged,
                        decoration: const InputDecoration(
                          labelText: 'Note',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension _ToCreateDto on TransactionReadDto {
  TransactionCreateDto toCreateDto() => TransactionCreateDto(
        amount: amount,
        isIncome: isIncome,
        sourceOrPurpose: sourceOrPurpose,
        note: note,
      );
}
