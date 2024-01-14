import 'package:dio/dio.dart';

// ignore: implementation_imports
import 'package:dio/src/adapters/browser_adapter.dart';

import '../../config.dart';

Dio client() => Dio(BaseOptions()..baseUrl = apiBaseUrl)
  ..httpClientAdapter = BrowserHttpClientAdapter(withCredentials: true);
