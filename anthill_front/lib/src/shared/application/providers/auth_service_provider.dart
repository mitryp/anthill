import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/auth_service.dart';
import 'http_client_provider.dart';

part 'auth_service_provider.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  final client = ref.watch(httpClientProvider);

  return AuthService(client);
}
