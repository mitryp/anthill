import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

PaginationController restoreController(
  QueryParams params, {
  PaginateConfig paginateConfig = const PaginateConfig(),
  bool validateColumns = true,
  bool strictValidation = true,
}) {
  final filterEntries = params.entries.where((entry) => entry.key.startsWith('filter.')).map((e) {
    final MapEntry(:key, :value) = e;
    final filterStrings = (value is List<String> ? value : [value]).cast<String>();

    return MapEntry(key.replaceFirst('filter.', ''), filterStrings.map(_parseFilter).toSet());
  });
  final sorts = (params['sortBy'] as Map<String, String>?)?.map(
    (key, value) => MapEntry(key, SortOrder.fromName(value)),
  );

  return PaginationController(
    paginateConfig: paginateConfig,
    validateColumns: validateColumns,
    strictValidation: strictValidation,
    limit: params['limit'] as int? ?? paginateConfig.defaultLimit,
    page: params['page'] as int? ?? 1,
    search: params['search'],
    filters: Map.fromEntries(filterEntries),
    sorts: sorts ?? paginateConfig.defaultSortBy,
  );
}

FilterOperator _parseFilter(String filterStr) {
  final [filterRepr, filterValue] = filterStr.split(':');
  final value = num.tryParse(filterValue) ?? filterValue;

  return switch (filterRepr.substring(1)) {
    'eq' => Eq(value),
    'lt' => Lt(value),
    'lte' => Lt(value, orEqual: true),
    'gt' => Gt(value),
    'gte' => Gt(value, orEqual: true),
    'sw' => Sw(value),
    'ilike' => Ilike(value),
    'btw' => (() {
        final [a, b] = (value as String).split(',').map(_parseFilterValue).toList(growable: false);

        return Btw(a, b);
      })(),
    'or' => Or(_parseFilter(filterValue)),
    'not' => Not(_parseFilter(filterValue)),
    'null' => const Null(),
    _ => throw UnsupportedError('Got an unsupported filter for restoration: $filterStr')
  };
}

Object _parseFilterValue(String value) => num.tryParse(value) ?? value;
