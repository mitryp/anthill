import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/providers/http_client_provider.dart';
import '../services/logging_service.dart';

part 'logging_service_provider.g.dart';

@riverpod
LoggingService loggingService(LoggingServiceRef ref) {
  final client = ref.watch(httpClientProvider);

  return LoggingService(client: client);
}
