import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/logging/logging_module.dart';
import '../../domain/interfaces/model.dart';
import 'dio_error_interceptor.dart';
import 'http_service.dart';

mixin CollectionControllerMixin<TRead extends IdentifiableModel, TCreate extends Model,
    TUpdate extends Model, TService extends HttpWriteMixin<TRead, TCreate, TUpdate>> {
  ProviderBase<TService> get serviceProvider;

  ProviderOrFamily get collectionProvider;

  ProviderOrFamily Function(int id) get resourceByIdProvider;

  AutoDisposeAsyncNotifierProviderRef get ref;

  TService _readService() => ref.read(serviceProvider);

  void invalidateCollectionProvider() => ref.invalidate(collectionProvider);

  void invalidateSingleResourceProviderWithId(int id) => ref.invalidate(resourceByIdProvider(id));

  void invalidateLogsProvider() => ref.invalidate(logsProvider);

  Future<TRead> createResource(TCreate dto, [BuildContext? context]) =>
      _readService().create(dto).whenComplete(() {
        invalidateCollectionProvider();
        invalidateLogsProvider();
      }).onError(
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
        invalidateLogsProvider();
      }).onError(
        (error, stackTrace) => interceptDioError(error, stackTrace, context: context),
        test: isDioError,
      );

  Future<bool> deleteResource(int id, [BuildContext? context]) =>
      _readService().delete(id).whenComplete(() {
        invalidateCollectionProvider();
        invalidateLogsProvider();
      }).onError(
        (error, stackTrace) => interceptDioError(
          error,
          stackTrace,
          context: context,
          returnValue: false,
        ),
        test: isDioError,
      );

  Future<bool> restoreResource(int id, [BuildContext? context]) =>
      _readService().restore(id).whenComplete(() {
        invalidateSingleResourceProviderWithId(id);
        invalidateCollectionProvider();
        invalidateLogsProvider();
      }).onError(
        (error, stackTrace) => interceptDioError(
          error,
          stackTrace,
          context: context,
          returnValue: false,
        ),
        test: isDioError,
      );
}
