import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

import '../presentation/widgets/search_controls.dart';
import '../presentation/widgets/single_sort_selector.dart';

class PaginationControlRow extends StatelessWidget {
  static const defaultInputDecoration = InputDecorationTheme(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 12),
  );

  final PaginationController controller;
  final bool isLocked;
  final InputDecorationTheme inputDecorationTheme;
  final bool includeSearch;
  final bool includeSort;

  const PaginationControlRow({
    required this.controller,
    this.isLocked = false,
    this.inputDecorationTheme = defaultInputDecoration,
    this.includeSearch = true,
    this.includeSort = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(inputDecorationTheme: inputDecorationTheme),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (includeSearch)
            Expanded(
              child: SearchControls(
                paginationController: controller,
                isLocked: isLocked,
              ),
            ),
          if (includeSearch && includeSort) const SizedBox(width: 16),
          if (includeSort)
            Expanded(
              child: SingleSortSelector(
                controller: controller,
                isLocked: isLocked,
              ),
            ),
        ],
      ),
    );
  }
}
