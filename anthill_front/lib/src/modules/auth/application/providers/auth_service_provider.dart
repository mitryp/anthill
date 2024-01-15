import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../services/auth_service.dart';

part 'auth_service_provider.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  final client = ref.watch(httpClientProvider);

  return AuthService(client);
}
