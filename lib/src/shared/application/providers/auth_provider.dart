import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_service_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  // todo
  @override
  Future<bool> build() => ref.watch(authServiceProvider).isAuthorized();
}
