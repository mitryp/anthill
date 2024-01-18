import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/dtos/user_read_dto.dart';
import 'user_service_provider.dart';

part 'user_by_id_provider.g.dart';

@riverpod
Future<UserReadDto> userById(UserByIdRef ref, int id) => ref.watch(userServiceProvider).getOne(id);
