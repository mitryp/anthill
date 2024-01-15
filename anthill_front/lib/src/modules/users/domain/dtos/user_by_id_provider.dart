import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/http.dart';
import '../../application/providers/user_service_provider.dart';
import 'user_read_dto.dart';

part 'user_by_id_provider.g.dart';

@riverpod
Future<UserReadDto> userById(UserByIdRef ref, int id, [BuildContext? context]) =>
    ref.watch(userServiceProvider).getOne(id).onError(
          (error, stackTrace) => interceptDioError(error, stackTrace, context: context),
          test: isDioError,
        );
