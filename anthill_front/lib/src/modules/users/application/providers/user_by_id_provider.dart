import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/dtos/user_read_dto.dart';
import 'user_service_provider.dart';

part 'user_by_id_provider.g.dart';

@Riverpod(keepAlive: true)
Future<UserReadDto> userById(UserByIdRef ref, int id) => ref.read(userServiceProvider).getOne(id);
