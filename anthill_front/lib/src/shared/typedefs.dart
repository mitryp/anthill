import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

export 'domain/constraints/module.dart';

typedef JsonMap = Map<String, Object?>;

typedef PageBuilder = Widget Function(BuildContext context, GoRouterState state);

typedef ButtonBuilder = Widget Function({
  required VoidCallback? onPressed,
  required Widget child,
  ButtonStyle? style,
});

typedef IconButtonBuilder = Widget Function({
  required VoidCallback? onPressed,
  required Widget icon,
  required Widget label,
  ButtonStyle? style,
});

typedef FutureVoidCallback = FutureOr<void> Function();
