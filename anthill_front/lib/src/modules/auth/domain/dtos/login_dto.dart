import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_dto.freezed.dart';

part 'login_dto.g.dart';

@freezed
class LoginDto with _$LoginDto {
  const factory LoginDto({
    required String email,
    required String password,
  }) = _LoginDto;

  factory LoginDto.fromJson(Map<String, Object?> json) => _$LoginDtoFromJson(json);
}
