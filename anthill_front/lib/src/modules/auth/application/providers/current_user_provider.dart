import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../users/domain/dtos/user_read_dto.dart';
import 'auth_provider.dart';

part 'current_user_provider.g.dart';

@riverpod
UserReadDto currentUser(CurrentUserRef ref) {
  final value = ref.watch(authProvider);

  late final error = StateError('Current user was accessed too early');

  return value.maybeWhen(
    data: (data) => data ?? (throw error),
    orElse: () => throw error,
  );
}
