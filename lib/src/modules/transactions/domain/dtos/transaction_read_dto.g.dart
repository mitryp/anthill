// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_read_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionReadDtoImpl _$$TransactionReadDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionReadDtoImpl(
      id: json['id'] as int,
      createDate: DateTime.parse(json['createDate'] as String),
      deleteDate: json['deleteDate'] == null
          ? null
          : DateTime.parse(json['deleteDate'] as String),
      amount: (json['amount'] as num).toDouble(),
      isIncome: json['isIncome'] as bool,
      sourceOrPurpose: json['sourceOrPurpose'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$$TransactionReadDtoImplToJson(
        _$TransactionReadDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate.toIso8601String(),
      'deleteDate': instance.deleteDate?.toIso8601String(),
      'amount': instance.amount,
      'isIncome': instance.isIncome,
      'sourceOrPurpose': instance.sourceOrPurpose,
      'note': instance.note,
    };
