import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

import '../../pagination.dart';
import '../../widgets.dart';

typedef FieldLocalizer = String? Function(BuildContext context, String colName);

/// Allows the [localizer] to return null while still being functional for each possible colName.
String Function(String) _definedLocalizerDecorator(String? Function(String) localizer) =>
    (colName) => localizer(colName) ?? colName;

String? _debugLocalizer(BuildContext _, String __) => null;

String _localizer(BuildContext context, String colName) {
  final locale = context.locale;

  return switch (colName) {
    'createDate' => locale.sortByCreateDateLabel,
    'amount' => locale.sortByAmountLabel,
    'sourceOrPurpose' => locale.sortBySourceOrPurposeLabel,
    'name' => locale.sortByNameLabel,
    _ => _camelCaseToTextTransformer(colName),
  };
}

/// Matches an uppercase letter preceded by a lowercase letter.
final _regex = RegExp(r'(?<=[a-z])[A-Z]');

String _camelCaseToTextTransformer(String camelCaseString) {
  if (camelCaseString.isEmpty) {
    return camelCaseString;
  }

  final transformed = camelCaseString.replaceAllMapped(
    _regex,
    (match) => ' ${match.group(0)}'.toLowerCase(),
  );

  return '${transformed[0].toUpperCase()}${transformed.length > 1 ? transformed.substring(1) : ''}';
}

class SingleSortSelector extends StatelessWidget {
  final PaginationController controller;
  final FieldLocalizer localizer;
  final bool isLocked;

  const SingleSortSelector({
    required this.controller,
    this.localizer = _localizer,
    this.isLocked = false,
    super.key,
  });

  MapEntry<String, SortOrder>? get _currentSort => controller.sorts.entries.firstOrNull;

  void _changeSortFieldTo(String? field) {
    final currentSort = _currentSort;
    if (field == null || currentSort?.key == field) return;

    controller.silently(
      notifyAfter: true,
      (controller) => controller
        ..page = 1
        ..clearSorts()
        ..addSort(field, currentSort?.value ?? SortOrder.asc),
    );
  }

  void _flipSortOrder() {
    final currentSortField = _currentSort?.key;
    if (currentSortField == null) return;

    controller.silently(
      notifyAfter: true,
      (controller) => controller
        ..flipSortBy(currentSortField)
        ..page = 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    const iconSize = 24.0;
    final localizer = _definedLocalizerDecorator((colName) => this.localizer(context, colName));

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final currentSort = _currentSort;
        final sortableColumns = controller.paginateConfig.sortableColumns;
        final defaultSort = controller.paginateConfig.defaultSortBy.entries.firstOrNull ??
            (sortableColumns.isNotEmpty ? MapEntry(sortableColumns.first, SortOrder.asc) : null);

        final items = sortableColumns
            .map(
              (colName) => DropdownMenuItem(
                value: colName,
                child: Text(localizer(colName)),
              ),
            )
            .toList(growable: false);

        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                icon: const SizedBox(),
                decoration: InputDecoration(
                  labelText: context.locale.paginationSingleSortSelectorLabel,
                  suffixIcon: IconButton(
                    onPressed: !isLocked ? _flipSortOrder : null,
                    splashRadius: iconSize,
                    icon: Icon(
                      currentSort?.value == SortOrder.desc
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      size: iconSize,
                    ),
                  ),
                ),
                value: currentSort?.key ?? defaultSort?.key,
                items: items,
                onChanged: !isLocked ? _changeSortFieldTo : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
