import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

typedef JsonMap = Map<String, Object?>;

typedef QueryParams = JsonMap;

typedef FromJsonDecoder<M> = M Function(JsonMap json);

typedef PageBuilder = Widget Function(BuildContext context, GoRouterState state);
