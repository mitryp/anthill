import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/transactions/application/providers/transaction_by_id_provider.dart';
import '../../domain/interfaces/model.dart';
import 'dio_error_interceptor.dart';
import 'http_service.dart';

mixin CollectionControllerMixin<TRead, TCreate extends Model, TUpdate extends Model,
    TService extends HttpWriteMixin<TRead, TCreate, TUpdate>> {
  ProviderBase<TService> get serviceProvider;

  ProviderOrFamily get collectionProvider;

  ProviderOrFamily Function(int id) get resourceByIdProvider;

  AutoDisposeAsyncNotifierProviderRef get ref;

  TService _readService() => ref.read(serviceProvider);

  void invalidateCollectionProvider() => ref.invalidate(collectionProvider);

  void invalidateSingleResourceProviderWithId(int id) =>
      ref.invalidate(transactionByIdProvider(id));

  Future<TRead> createResource(TCreate dto, [BuildContext? context]) =>
      _readService().create(dto).whenComplete(invalidateCollectionProvider).onError(
            (error, stackTrace) => interceptDioError<TRead>(
              error,
              stackTrace,
              context: context,
            ),
            test: isDioError,
          );

  Future<TRead> updateResource(
    int id,
    TUpdate dto, [
    BuildContext? context,
  ]) =>
      _readService().update(id, dto).whenComplete(() {
        invalidateSingleResourceProviderWithId(id);
        invalidateCollectionProvider();
      }).onError(
        (error, stackTrace) => interceptDioError(error, stackTrace, context: context),
        test: isDioError,
      );

  Future<bool> deleteResource(int id, [BuildContext? context]) =>
      _readService().delete(id).whenComplete(invalidateCollectionProvider).onError(
            (error, stackTrace) => interceptDioError(error, stackTrace, context: context),
            test: isDioError,
          );
}
