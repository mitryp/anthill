import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/transactions/application/providers/transaction_provider.dart';
import '../../domain/interfaces/model.dart';
import 'dio_error_interceptor.dart';
import 'http_service.dart';

mixin CollectionControllerMixin<TRead, TService extends HttpService<TRead>>
    on AutoDisposeAsyncNotifier<List<TRead>> {
  ProviderBase<TService> get serviceProvider;

  void invalidateSingleResourceProviderWithId(int id) {}

  TService _readService() => ref.read(serviceProvider);

  @override
  Future<List<TRead>> build() => ref.watch(serviceProvider).getMany();
}

mixin ModifiableCollectionControllerMixin<TRead, TCreate extends Model, TUpdate extends Model,
        TService extends HttpWriteMixin<TRead, TCreate, TUpdate>>
    on CollectionControllerMixin<TRead, TService> {
  Future<TRead> createResource(TCreate dto, [BuildContext? context]) =>
      _readService().create(dto).then((created) {
        ref.invalidateSelf();

        return future.then((_) => created);
      }).onError((error, stackTrace) => interceptDioError(error, stackTrace, context));

  Future<TRead> updateResource(
    int id,
    TUpdate dto, [
    BuildContext? context,
  ]) =>
      _readService().update(id, dto).then((updated) {
        ref.invalidateSelf();
        invalidateSingleResourceProviderWithId(id);

        return future.then((_) => updated);
      }).onError((error, stackTrace) => interceptDioError(error, stackTrace, context));

  Future<bool> deleteResource(int id, [BuildContext? context]) =>
      _readService().delete(id).then((deleted) async {
        if (!deleted) {
          return deleted;
        }

        ref.invalidateSelf();

        return future.then((_) => deleted);
      }).onError((error, stackTrace) => interceptDioError(error, stackTrace, context));
}
