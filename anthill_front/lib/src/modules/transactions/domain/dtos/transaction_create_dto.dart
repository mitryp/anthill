import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/interfaces/model.dart';

part 'transaction_create_dto.freezed.dart';

part 'transaction_create_dto.g.dart';

@freezed
class TransactionCreateDto with _$TransactionCreateDto implements Model {
  const factory TransactionCreateDto({
    required double amount,
    required bool isIncome,
    required String sourceOrPurpose,
    @Default('') String note,
  }) = _TransactionCreateDto;

  factory TransactionCreateDto.fromJson(Map<String, Object?> json) =>
      _$TransactionCreateDtoFromJson(json);
}
