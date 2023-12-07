// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServerErrorDtoImpl _$$ServerErrorDtoImplFromJson(Map<String, dynamic> json) =>
    _$ServerErrorDtoImpl(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      error: json['error'] as String,
    );

Map<String, dynamic> _$$ServerErrorDtoImplToJson(_$ServerErrorDtoImpl instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'error': instance.error,
    };
