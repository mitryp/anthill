import 'package:go_router/go_router.dart';

import '../domain/interfaces/model.dart';

({int id, TModel? model}) modelFromRouterState<TModel extends IdentifiableModel>(
  GoRouterState state,
) {
  final idStr = state.pathParameters['id'];
  final extra = state.extra;
  final cachedModel = extra is TModel ? extra : null;

  final id = (idStr != null ? int.tryParse(idStr) : null) ?? cachedModel?.id;

  if (id == null) {
    throw StateError('Could not find $TModel id');
  }

  return (id: id, model: cachedModel);
}
