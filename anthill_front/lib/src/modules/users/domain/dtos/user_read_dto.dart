import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/http.dart';
import '../constraints/user_role.dart';

part 'user_read_dto.freezed.dart';

part 'user_read_dto.g.dart';

@freezed
class UserReadDto with _$UserReadDto implements IdentifiableModel {
  const factory UserReadDto({
    required int id,
    required DateTime createDate,
    DateTime? deleteDate,
    required String name,
    required String email,
    required UserRole role,
  }) = _UserReadDto;

  factory UserReadDto.fromJson(Map<String, Object?> json) => _$UserReadDtoFromJson(json);
}
