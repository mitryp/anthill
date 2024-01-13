import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../http/http_service.dart';

part 'paginate_config_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PaginateConfig> paginateConfig(
  PaginateConfigRef ref,
  ProviderBase<HttpService> httpServiceProvider,
) =>
    ref.read(httpServiceProvider).getPaginateConfig();
