import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/dto/server_error_dto.dart';
import '../../domain/interfaces/model.dart';
import '../../presentation/snack_bar_content.dart';
import '../../typedefs.dart';
import 'http_service.dart';

mixin CollectionControllerMixin<TRead, TCreate extends Model, TUpdate extends Model,
        TService extends HttpWriteMixin<TRead, TCreate, TUpdate>>
    on AutoDisposeAsyncNotifier<List<TRead>> {
  ProviderBase<TService> get serviceProvider;

  TService _readService() => ref.read(serviceProvider);

  @override
  Future<List<TRead>> build() => ref.watch(serviceProvider).getMany();

  Future<TRead> createTransaction(TCreate dto, [BuildContext? context]) =>
      _readService().create(dto).then((created) {
        ref.invalidateSelf();

        return future.then((_) => created);
      }).onError((error, stackTrace) => _interceptError(error, stackTrace, context));

  Future<TRead> updateTransaction(
    int id,
    TUpdate dto, [
    BuildContext? context,
  ]) =>
      _readService().update(id, dto).then((updated) {
        ref.invalidateSelf();

        return future.then((_) => updated);
      }).onError((error, stackTrace) => _interceptError(error, stackTrace, context));

  Future<TRead> deleteTransaction(int id, [BuildContext? context]) =>
      _readService().delete(id).then((deleted) {
        ref.invalidateSelf();

        return future.then((_) => deleted);
      }).onError((error, stackTrace) => _interceptError(error, stackTrace, context));

  Future<R> _interceptError<R>(Object? error, StackTrace stackTrace, [BuildContext? context]) {
    if (error is DioException && context != null) {
      final data = error.response?.data;

      if (data != null && data is JsonMap) {
        final errorDto = ServerErrorDto.fromJson(data);

        showSnackBar(
          context,
          title: Text('${errorDto.statusCode} ${errorDto.error}'),
          subtitle: Text(errorDto.message),
          backgroundColor: Colors.red.shade200,
        );
      }
    }

    throw error ?? 'Something is terribly wrong';
  }
}
