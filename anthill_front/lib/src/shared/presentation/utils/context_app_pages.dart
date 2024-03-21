import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../constraints/app_page.dart';

extension ContextAppPages on BuildContext {
  Future<T?> pushPage<T>(AppPage page, {Object? extra, int? resourceId}) =>
      push<T>(page.formatLocation(resourceId), extra: extra);

  void goPage(AppPage page, {Object? extra, int? resourceId}) =>
      go(page.formatLocation(resourceId), extra: extra);
}
