import 'package:flutter/material.dart';

import '../../widgets.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final Widget child;

  const PageTitle({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Title(
      title: '$title | ${context.locale.appName}',
      color: Colors.blueAccent,
      child: child,
    );
  }
}
