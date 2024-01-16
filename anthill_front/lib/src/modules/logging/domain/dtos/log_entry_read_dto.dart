import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/http.dart';
import '../../../users/domain/dtos/user_read_dto.dart';

part 'log_entry_read_dto.freezed.dart';
part 'log_entry_read_dto.g.dart';

@freezed
class LogEntryReadDto with _$LogEntryReadDto implements IdentifiableModel {
  const factory LogEntryReadDto({
    required int id,
    required DateTime createDate,
    required UserReadDto user,
    required String action,
    required String moduleName,
    String? resourceAffected,
    int? targetEntityId,
    Map<String, dynamic>? jsonPayload,
  }) = _LogEntryReadDto;

  const LogEntryReadDto._();

  factory LogEntryReadDto.fromJson(Map<String, Object?> json) => _$LogEntryReadDtoFromJson(json);

  // logs are never deleted
  @override
  DateTime? get deleteDate => null;
}
