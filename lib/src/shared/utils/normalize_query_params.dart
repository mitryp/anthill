import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

extension NormalizeQueryParams on Map<String, List<String>> {
  /// Transforms this map to a structure compatible with [PaginationController].
  Map<String, Object> normalize() => map((key, value) => MapEntry(
      key,
      value.length == 1
          ? _parseValue(value.single)
          : value.map(_parseValue).toList(growable: false)));
}

Object _parseValue(String value) => num.tryParse(value) ?? value;
