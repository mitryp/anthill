import 'dart:math';

import 'package:flutter/material.dart';

class PageBody extends StatelessWidget {
  static const double defaultMaxWidth = 512.0;

  final Widget child;
  final double maxWidth;

  const PageBody({
    required this.child,
    this.maxWidth = defaultMaxWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewWidth = MediaQuery.of(context).size.width;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: min(maxWidth, viewWidth)),
        child: child,
      ),
    );
  }
}
