import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

import '../../pagination.dart';
import '../../widgets.dart';

typedef DateFormatter = String Function(DateTime);

class DateRangeFilter extends StatelessWidget {
  final PaginationController _controller;
  final String filterKey;
  final String? placeholder;
  final DateFormatter formatter;

  const DateRangeFilter({
    required PaginationController controller,
    this.filterKey = 'createDate',
    this.placeholder,
    this.formatter = serializeDateQueryParam,
    super.key,
  }) : _controller = controller;

  Future<void> _selectDateRange(BuildContext context, {DateTimeRange? selectedRange}) async {
    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      initialDateRange: selectedRange,
    );

    if (dateRange == null) {
      _controller.removeFilter(filterKey);
      return;
    }

    _controller.silently(
      notifyAfter: true,
      (controller) => controller
        ..removeFilter(filterKey)
        ..addFilter(
          filterKey,
          Btw(
            formatter(dateRange.start),
            formatter(dateRange.end.add(const Duration(days: 1))),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = context.locale.paginationDateRangeFilterPlaceholder;

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final maybeRange = _controller.extractDateRange(byKey: filterKey);

        final label = Text(
          maybeRange != null
              ? '${formatDate(maybeRange.start).date} - ${formatDate(maybeRange.end).date}'
              : placeholder,
        );

        return FilterChip(
          selected: maybeRange != null,
          label: label,
          onSelected: (_) => _selectDateRange(context),
        );
      },
    );
  }
}
