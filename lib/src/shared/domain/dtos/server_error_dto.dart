import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_error_dto.freezed.dart';

part 'server_error_dto.g.dart';

@freezed
class ServerErrorDto with _$ServerErrorDto {
  const factory ServerErrorDto({
    required int statusCode,
    required String message,
    String? error,
  }) = _ServerErrorDto;

  const ServerErrorDto._();

  factory ServerErrorDto.fromJson(Map<String, Object?> json) => _$ServerErrorDtoFromJson(json);

  @override
  String toString() => '$statusCode $error: $message';
}
