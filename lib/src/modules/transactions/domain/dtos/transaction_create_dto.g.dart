// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionCreateDtoImpl _$$TransactionCreateDtoImplFromJson(Map<String, dynamic> json) =>
    _$TransactionCreateDtoImpl(
      amount: (json['amount'] as num).toDouble(),
      isIncome: json['isIncome'] as bool,
      sourceOrPurpose: json['sourceOrPurpose'] as String,
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$$TransactionCreateDtoImplToJson(_$TransactionCreateDtoImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'isIncome': instance.isIncome,
      'sourceOrPurpose': instance.sourceOrPurpose,
      'note': instance.note,
    };
