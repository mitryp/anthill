import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/exceptions/no_resource_error.dart';
import '../../typedefs.dart';
import 'http_client_provider.dart';

part 'paginate_config_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PaginateConfig> paginateConfig(PaginateConfigRef ref, String resourceName) {
  final client = ref.read(httpClientProvider);

  return client.get<JsonMap>('$resourceName/paginate_config').then((res) {
    final data = res.data;

    if (data == null) {
      throw NoResourceError('$resourceName/paginate_config');
    }

    return PaginateConfig.fromJson(data);
  });
}
