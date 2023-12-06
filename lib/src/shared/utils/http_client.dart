import 'package:dio/dio.dart';

import '../../config.dart';

Dio client() => Dio(BaseOptions(baseUrl: apiBaseUrl));
