import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../services/user_service.dart';

part 'user_service_provider.g.dart';

@riverpod
UserService userService(UserServiceRef ref) {
  final client = ref.watch(httpClientProvider);

  return UserService(client: client);
}
