import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../users/domain/dtos/user_read_dto.dart';

part 'log_entry_read_dto.freezed.dart';
part 'log_entry_read_dto.g.dart';

@freezed
class LogEntryReadDto with _$LogEntryReadDto {
  const factory LogEntryReadDto({
    required UserReadDto user,
    required String action,
    required String moduleName,
    String? resourceAffected,
    int? targetEntityId,
    Map<String, dynamic>? jsonPayload,
  }) = _LogEntryReadDto;

  factory LogEntryReadDto.fromJson(Map<String, Object?> json) => _$LogEntryReadDtoFromJson(json);
}
