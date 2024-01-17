import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

extension ControllerNegateFilter on PaginationController {
  /// Negates a filter by the given [field].
  ///
  /// If no filter is configured for the field, will use [orElse] value. If it's not given,
  /// no action will be conducted.
  ///
  /// If the current operator is [Not], will extract the inner operator and set it.
  /// Otherwise, will wrap the current operator in a [Not] operator.
  ///
  /// This will work exclusively with a single [FilterOperator] per field.
  /// If there are more than one filter configured for the [field], will throw a StateError
  void negateFilter(String field, {FilterOperator? orElse, bool notifyAfter = false}) {
    final currentFilter = filters[field]?.single;

    final replacementFilter = switch (currentFilter) {
      Not(value: final FilterOperator innerOperator) => innerOperator,
      FilterOperator() => Not(currentFilter),
      _ => orElse ?? currentFilter,
    };

    if (replacementFilter == null || replacementFilter == currentFilter) {
      return;
    }

    silently(
      notifyAfter: notifyAfter,
      (controller) => controller
        ..removeFilter(field, currentFilter)
        ..addFilter(field, replacementFilter),
    );
  }
}
