import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../constraints/app_page.dart';

extension ContextAppPages on BuildContext {
  Future<T?> pushPage<T>(AppPage page, {Object? extra}) => push<T>(page.location, extra: extra);

  void goPage(AppPage page, {Object? extra}) => go(page.location, extra: extra);
}
