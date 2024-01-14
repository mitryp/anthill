import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../users/users_module.dart';
import '../../domain/dtos/login_dto.dart';
import 'auth_service_provider.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  Future<bool> login(LoginDto loginDto) =>
      ref.read(authServiceProvider).login(loginDto).whenComplete(ref.invalidateSelf);

  @override
  Future<UserReadDto?> build() async {
    final user = await ref.watch(authServiceProvider).restore();

    state = AsyncValue.data(user);

    return user;
  }
}
