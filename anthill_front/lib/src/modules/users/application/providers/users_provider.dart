import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/http/invalidate_on_error.dart';
import '../../domain/dtos/user_read_dto.dart';
import 'user_service_provider.dart';

part 'users_provider.g.dart';

@riverpod
Future<Paginated<UserReadDto>> users(UsersRef ref, QueryParams params) =>
    ref.watch(userServiceProvider).getMany(params).invalidateOnError(ref);
