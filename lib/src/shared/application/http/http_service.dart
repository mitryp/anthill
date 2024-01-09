import 'package:dio/dio.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

import '../../domain/exceptions/no_resource_error.dart';
import '../../domain/interfaces/model.dart';
import '../../typedefs.dart';

const _paginateConfigEndpoint = 'paginate_config';

abstract class HttpService<TRead> {
  final Dio client;
  final String apiPrefix;
  final FromJsonDecoder<TRead> decoder;

  const HttpService({required this.client, required this.apiPrefix, required this.decoder});

  Future<TRead> getOne(int id) => client.get<JsonMap>('$apiPrefix/$id').then(_decodeOneResponse);

  Future<Paginated<TRead>> getMany([QueryParams? params]) =>
      client.get<JsonMap>(apiPrefix, queryParameters: params).then((res) {
        final data = res.data;

        if (data == null) {
          throw NoResourceError('Paginated<$TRead>');
        }

        return Paginated.fromJson(data, decoder);
      });

  Future<PaginateConfig> getPaginateConfig() =>
      client.get<JsonMap>('$apiPrefix/$_paginateConfigEndpoint').then(_decodeConfigResponse);

  PaginateConfig _decodeConfigResponse(Response<JsonMap> res) {
    final data = res.data;

    if (data == null) {
      throw NoResourceError('PaginateConfig($TRead)');
    }

    return PaginateConfig.fromJson(data);
  }

  TRead _decodeOneResponse(Response<JsonMap> res) {
    final data = res.data;

    if (data == null) {
      throw NoResourceError('$TRead');
    }

    return decoder.call(data);
  }
}

mixin HttpWriteMixin<TRead, TCreate extends Model, TUpdate extends Model> on HttpService<TRead> {
  Future<TRead> create(TCreate model) =>
      client.post<JsonMap>(apiPrefix, data: model.toJson()).then(_decodeOneResponse);

  Future<TRead> update(int id, TUpdate model) =>
      client.patch<JsonMap>('$apiPrefix/$id', data: model.toJson()).then(_decodeOneResponse);

  Future<bool> delete(int id) =>
      client.delete<String>('$apiPrefix/$id').then((value) => value.data == 'true');
}
