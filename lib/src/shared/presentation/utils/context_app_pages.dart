import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../constraints/app_page.dart';

extension ContextAppPages on BuildContext {
  Future<T?> pushPage<T>(AppPage page, {Object? extra, int? resourceId}) =>
      push<T>(_formatLocation(page, resourceId), extra: extra);

  void goPage(AppPage page, {Object? extra, int? resourceId}) =>
      go(_formatLocation(page, resourceId), extra: extra);
}

String _formatLocation(AppPage page, int? resourceId) {
  if (resourceId == null) {
    return page.location;
  }

  return page.location.replaceAll(idParamPlaceholder, '$resourceId');
}
