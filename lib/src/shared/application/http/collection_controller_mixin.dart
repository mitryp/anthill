import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/interfaces/model.dart';
import 'dio_error_interceptor.dart';
import 'http_service.dart';

mixin CollectionControllerMixin<TRead, TService extends HttpService<TRead>>
    on AutoDisposeAsyncNotifier<List<TRead>> {
  ProviderBase<TService> get serviceProvider;

  TService _readService() => ref.read(serviceProvider);

  @override
  Future<List<TRead>> build() => ref.watch(serviceProvider).getMany();
}

mixin ModifiableCollectionControllerMixin<TRead, TCreate extends Model, TUpdate extends Model,
        TService extends HttpWriteMixin<TRead, TCreate, TUpdate>>
    on CollectionControllerMixin<TRead, TService> {
  Future<TRead> createTransaction(TCreate dto, [BuildContext? context]) =>
      _readService().create(dto).then((created) {
        ref.invalidateSelf();

        return future.then((_) => created);
      }).onError((error, stackTrace) => interceptDioError(error, stackTrace, context));

  Future<TRead> updateTransaction(
    int id,
    TUpdate dto, [
    BuildContext? context,
  ]) =>
      _readService().update(id, dto).then((updated) {
        ref.invalidateSelf();

        return future.then((_) => updated);
      }).onError((error, stackTrace) => interceptDioError(error, stackTrace, context));

  Future<bool> deleteTransaction(int id, [BuildContext? context]) =>
      _readService().delete(id).then((deleted) {
        ref.invalidateSelf();

        return future.then((_) => deleted);
      }).onError((error, stackTrace) => interceptDioError(error, stackTrace, context));
}
