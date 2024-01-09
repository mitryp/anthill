import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

import '../../utils/controller_flip_sort.dart';

typedef FieldLocalizer = String Function(BuildContext context, String string);

String _debugLocalizer(BuildContext _, String s) => s;

class SingleSortSelector extends StatelessWidget {
  final PaginationController controller;
  final FieldLocalizer localizer;

  const SingleSortSelector({
    required this.controller,
    this.localizer = _debugLocalizer,
    super.key,
  });

  MapEntry<String, SortOrder>? get _currentSort => controller.sorts.entries.firstOrNull;

  void _changeSortFieldTo(String? field) {
    final currentSort = _currentSort;
    if (field == null || currentSort?.key == field) return;

    controller.silently(
      notifyAfter: true,
      (controller) => controller
        ..clearSorts()
        ..addSort(field, currentSort?.value ?? SortOrder.asc),
    );
  }

  void _flipSortOrder() {
    final currentSortField = _currentSort?.key;
    if (currentSortField == null) return;

    controller.flipSortBy(currentSortField);
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text(localizer(context, colName)),
              ),
            )
            .toList(growable: false);

        return Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: currentSort?.key ?? defaultSort?.key,
                items: items,
                onChanged: _changeSortFieldTo,
              ),
            ),
            IconButton(
              onPressed: _flipSortOrder,
              icon: Icon(
                currentSort?.value == SortOrder.desc ? Icons.arrow_drop_down : Icons.arrow_drop_up,
              ),
            ),
          ],
        );
      },
    );
  }
}
