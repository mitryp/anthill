import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

import '../../utils/date_transfer_format.dart';

extension ExtractDateRange on PaginationController {
  DateTimeRange? extractDateRange({required String byKey}) {
    final filter = filters[byKey]?.firstOrNull;

    final (start, end) = switch (filter) {
      Btw(value: final value) when value is (String, String) => (
          deserializeDateQueryParam(value.$1),
          deserializeDateQueryParam(value.$2),
        ),
      _ => (null, null),
    };

    return start != null && end != null ? DateTimeRange(start: start, end: end) : null;
  }
}
