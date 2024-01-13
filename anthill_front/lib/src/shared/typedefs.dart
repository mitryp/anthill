import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

typedef JsonMap = Map<String, Object?>;

typedef PageBuilder = Widget Function(BuildContext context, GoRouterState state);
