import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

import '../../widgets.dart';

class DeleteFilter extends StatelessWidget {
  final PaginationController _controller;
  final String _filterKey;
  final FilterOperator? _includeDeletedFilter;
  final FilterOperator? _notIncludeDeletedFilter;

  const DeleteFilter({
    required PaginationController controller,
    String filterKey = 'deleteDate',
    FilterOperator? withDeleted,
    FilterOperator? withoutDeleted = const Null(),
    super.key,
  })  : _notIncludeDeletedFilter = withoutDeleted,
        _includeDeletedFilter = withDeleted,
        _filterKey = filterKey,
        _controller = controller;

  void _onSelected(bool includeDeleted) => _controller.silently(
        notifyAfter: true,
        (controller) {
          controller.removeFilter(_filterKey);

          final filterToAdd = includeDeleted ? _includeDeletedFilter : _notIncludeDeletedFilter;
          if (filterToAdd == null) return;
          controller.addFilter(_filterKey, filterToAdd);
        },
      );

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final includeDeleted = _controller.filters[_filterKey]?.single == _includeDeletedFilter;

        return FilterChip(
          label: Text(locale.paginationShowDeletedSwitchLabel),
          onSelected: _onSelected,
          selected: includeDeleted,
        );
      },
    );
  }
}
