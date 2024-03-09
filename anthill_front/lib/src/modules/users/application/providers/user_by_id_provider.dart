import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/http/invalidate_on_error.dart';
import '../../../../shared/utils/cache_for.dart';
import '../../domain/dtos/user_read_dto.dart';
import 'user_service_provider.dart';

part 'user_by_id_provider.g.dart';

@riverpod
Future<UserReadDto> userById(UserByIdRef ref, int id) {
  ref.cacheFor();

  return ref.watch(userServiceProvider).getOne(id).invalidateOnHttpError(ref);
}
