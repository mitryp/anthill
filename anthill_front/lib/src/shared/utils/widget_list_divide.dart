import 'package:flutter/widgets.dart';

extension WidgetListDivide on List<Widget> {
  List<Widget> divide(Widget divider) {
    if (length < 2) {
      return this;
    }

    final [head, ...tail] = this;

    Iterable<Widget> generate() sync* {
      yield head;

      for (final elem in tail) {
        yield divider;
        yield elem;
      }
    }

    return generate().toList();
  }
}
