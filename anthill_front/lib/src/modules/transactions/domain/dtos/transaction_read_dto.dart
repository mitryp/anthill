import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/http.dart';
import '../../../users/users_module.dart';

part 'transaction_read_dto.freezed.dart';

part 'transaction_read_dto.g.dart';

@freezed
class TransactionReadDto with _$TransactionReadDto implements IdentifiableModel {
  const factory TransactionReadDto({
    required int id,
    required DateTime createDate,
    DateTime? deleteDate,
    required double amount,
    required bool isIncome,
    required String sourceOrPurpose,
    required String note,
    required UserReadDto user,
  }) = _TransactionReadDto;

  factory TransactionReadDto.fromJson(Map<String, Object?> json) =>
      _$TransactionReadDtoFromJson(json);
}
