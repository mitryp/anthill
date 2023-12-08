import 'package:dio/dio.dart';

import '../../domain/exceptions/no_resource_error.dart';
import '../../domain/interfaces/model.dart';
import '../../typedefs.dart';

abstract class HttpService<TRead> {
  final Dio client;
  final String apiPrefix;
  final FromJsonDecoder<TRead> decoder;

  const HttpService({required this.client, required this.apiPrefix, required this.decoder});

  Future<TRead> getOne(int id) => client.get<JsonMap>('$apiPrefix/$id').then(_decodeOneResponse);

  Future<List<TRead>> getMany([QueryParams? params]) =>
      client.get<List>(apiPrefix).then(_decodeManyResponse);

  TRead _decodeOneResponse(Response<JsonMap> res) {
    final data = res.data;

    if (data == null) {
      throw NoResourceError('$TRead');
    }

    return decoder.call(data);
  }

  List<TRead> _decodeManyResponse(Response<List<dynamic>> res) {
    final list = res.data;

    if (list == null) {
      throw NoResourceError('$TRead');
    }

    return list.cast<JsonMap>().map(decoder.call).toList(growable: false);
  }
}

mixin HttpWriteMixin<TRead, TCreate extends Model, TUpdate extends Model> on HttpService<TRead> {
  Future<TRead> create(TCreate model) => client.post<JsonMap>(apiPrefix).then(_decodeOneResponse);

  Future<TRead> update(int id, TUpdate model) =>
      client.patch<JsonMap>('$apiPrefix/$id', data: model.toJson()).then(_decodeOneResponse);

  Future<bool> delete(int id) =>
      client.delete<String>('$apiPrefix/$id').then((value) => value.data == 'true');
}
