// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_error_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ServerErrorDto _$ServerErrorDtoFromJson(Map<String, dynamic> json) {
  return _ServerErrorDto.fromJson(json);
}

/// @nodoc
mixin _$ServerErrorDto {
  int get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServerErrorDtoCopyWith<ServerErrorDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerErrorDtoCopyWith<$Res> {
  factory $ServerErrorDtoCopyWith(ServerErrorDto value, $Res Function(ServerErrorDto) then) =
      _$ServerErrorDtoCopyWithImpl<$Res, ServerErrorDto>;
  @useResult
  $Res call({int statusCode, String message, String error});
}

/// @nodoc
class _$ServerErrorDtoCopyWithImpl<$Res, $Val extends ServerErrorDto>
    implements $ServerErrorDtoCopyWith<$Res> {
  _$ServerErrorDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerErrorDtoImplCopyWith<$Res> implements $ServerErrorDtoCopyWith<$Res> {
  factory _$$ServerErrorDtoImplCopyWith(
          _$ServerErrorDtoImpl value, $Res Function(_$ServerErrorDtoImpl) then) =
      __$$ServerErrorDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int statusCode, String message, String error});
}

/// @nodoc
class __$$ServerErrorDtoImplCopyWithImpl<$Res>
    extends _$ServerErrorDtoCopyWithImpl<$Res, _$ServerErrorDtoImpl>
    implements _$$ServerErrorDtoImplCopyWith<$Res> {
  __$$ServerErrorDtoImplCopyWithImpl(
      _$ServerErrorDtoImpl _value, $Res Function(_$ServerErrorDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
    Object? error = null,
  }) {
    return _then(_$ServerErrorDtoImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerErrorDtoImpl extends _ServerErrorDto {
  const _$ServerErrorDtoImpl({required this.statusCode, required this.message, required this.error})
      : super._();

  factory _$ServerErrorDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerErrorDtoImplFromJson(json);

  @override
  final int statusCode;
  @override
  final String message;
  @override
  final String error;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorDtoImpl &&
            (identical(other.statusCode, statusCode) || other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorDtoImplCopyWith<_$ServerErrorDtoImpl> get copyWith =>
      __$$ServerErrorDtoImplCopyWithImpl<_$ServerErrorDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerErrorDtoImplToJson(
      this,
    );
  }
}

abstract class _ServerErrorDto extends ServerErrorDto {
  const factory _ServerErrorDto(
      {required final int statusCode,
      required final String message,
      required final String error}) = _$ServerErrorDtoImpl;
  const _ServerErrorDto._() : super._();

  factory _ServerErrorDto.fromJson(Map<String, dynamic> json) = _$ServerErrorDtoImpl.fromJson;

  @override
  int get statusCode;
  @override
  String get message;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$ServerErrorDtoImplCopyWith<_$ServerErrorDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
