import 'package:flutter/cupertino.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../../domain/dtos/user_read_dto.dart';
import 'user_service_provider.dart';

part 'users_provider.g.dart';

@riverpod
Future<Paginated<UserReadDto>> users(
  UsersRef ref, {
  QueryParams params = const {},
  BuildContext? context,
}) =>
    ref.watch(userServiceProvider).getMany(params).onError(
          (error, stackTrace) => interceptDioError(error, stackTrace, context: context),
          test: isDioError,
        );
