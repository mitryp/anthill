import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

extension ControllerFlipSort on PaginationController {
  void flipSortBy(String field) {
    assert(paginateConfig.sortableColumns.contains(field));

    final sort = sorts[field];
    if (sort == null) return;

    addSort(field, sort.flipped());
  }
}
