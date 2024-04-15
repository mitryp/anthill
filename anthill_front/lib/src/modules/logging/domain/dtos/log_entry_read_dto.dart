import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/http.dart';
import '../../../../shared/typedefs.dart';
import '../../../users/domain/dtos/user_read_dto.dart';
import '../constraints/action.dart';

part 'log_entry_read_dto.freezed.dart';

part 'log_entry_read_dto.g.dart';

@freezed
class LogEntryReadDto with _$LogEntryReadDto implements IdentifiableModel {
  const factory LogEntryReadDto({
    required int id,
    required DateTime createDate,
    required UserReadDto user,
    @JsonKey(name: 'action') required String actionName,
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

  Module get module => Module.values.firstWhere((m) => m.name == moduleName);

  Action get action => Action.values.firstWhere((a) => actionName.startsWith(a.name));
}
