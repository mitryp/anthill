import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/http_client.dart';

part 'http_client_provider.g.dart';

@riverpod
Dio httpClient(HttpClientRef ref) => client();
