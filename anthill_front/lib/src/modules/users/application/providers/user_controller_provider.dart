// ignore_for_file: avoid_public_notifier_properties
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import 'user_by_id_provider.dart';
import '../../domain/dtos/user_create_dto.dart';
import '../../domain/dtos/user_read_dto.dart';
import '../services/user_service.dart';
import 'user_service_provider.dart';
import 'users_provider.dart';

part 'user_controller_provider.g.dart';

@riverpod
class UserController extends _$UserController
    with CollectionControllerMixin<UserReadDto, UserCreateDto, UserCreateDto, UserService> {
  @override
  ProviderOrFamily get collectionProvider => usersProvider;

  @override
  ProviderOrFamily Function(int id) get resourceByIdProvider => userByIdProvider;

  @override
  ProviderBase<UserService> get serviceProvider => userServiceProvider;

  @override
  FutureOr<void> build() {}
}
