import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/interfaces/model.dart';
import '../constraints/user_role.dart';

part 'user_create_dto.freezed.dart';

part 'user_create_dto.g.dart';

@freezed
class UserCreateDto with _$UserCreateDto implements Model {
  const factory UserCreateDto({
    required String name,
    required String email,
    required UserRole role,
    String? password,
  }) = _UserCreateDto;

  factory UserCreateDto.fromJson(Map<String, Object?> json) => _$UserCreateDtoFromJson(json);
}
