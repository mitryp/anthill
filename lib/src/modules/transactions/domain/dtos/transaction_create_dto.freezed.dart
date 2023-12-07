// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_create_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionCreateDto _$TransactionCreateDtoFromJson(Map<String, dynamic> json) {
  return _TransactionCreateDto.fromJson(json);
}

/// @nodoc
mixin _$TransactionCreateDto {
  double get amount => throw _privateConstructorUsedError;
  bool get isIncome => throw _privateConstructorUsedError;
  String get sourceOrPurpose => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCreateDtoCopyWith<TransactionCreateDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCreateDtoCopyWith<$Res> {
  factory $TransactionCreateDtoCopyWith(
          TransactionCreateDto value, $Res Function(TransactionCreateDto) then) =
      _$TransactionCreateDtoCopyWithImpl<$Res, TransactionCreateDto>;
  @useResult
  $Res call({double amount, bool isIncome, String sourceOrPurpose, String note});
}

/// @nodoc
class _$TransactionCreateDtoCopyWithImpl<$Res, $Val extends TransactionCreateDto>
    implements $TransactionCreateDtoCopyWith<$Res> {
  _$TransactionCreateDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? isIncome = null,
    Object? sourceOrPurpose = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isIncome: null == isIncome
          ? _value.isIncome
          : isIncome // ignore: cast_nullable_to_non_nullable
              as bool,
      sourceOrPurpose: null == sourceOrPurpose
          ? _value.sourceOrPurpose
          : sourceOrPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionCreateDtoImplCopyWith<$Res>
    implements $TransactionCreateDtoCopyWith<$Res> {
  factory _$$TransactionCreateDtoImplCopyWith(
          _$TransactionCreateDtoImpl value, $Res Function(_$TransactionCreateDtoImpl) then) =
      __$$TransactionCreateDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, bool isIncome, String sourceOrPurpose, String note});
}

/// @nodoc
class __$$TransactionCreateDtoImplCopyWithImpl<$Res>
    extends _$TransactionCreateDtoCopyWithImpl<$Res, _$TransactionCreateDtoImpl>
    implements _$$TransactionCreateDtoImplCopyWith<$Res> {
  __$$TransactionCreateDtoImplCopyWithImpl(
      _$TransactionCreateDtoImpl _value, $Res Function(_$TransactionCreateDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? isIncome = null,
    Object? sourceOrPurpose = null,
    Object? note = null,
  }) {
    return _then(_$TransactionCreateDtoImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isIncome: null == isIncome
          ? _value.isIncome
          : isIncome // ignore: cast_nullable_to_non_nullable
              as bool,
      sourceOrPurpose: null == sourceOrPurpose
          ? _value.sourceOrPurpose
          : sourceOrPurpose // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionCreateDtoImpl implements _TransactionCreateDto {
  const _$TransactionCreateDtoImpl(
      {required this.amount,
      required this.isIncome,
      required this.sourceOrPurpose,
      this.note = ''});

  factory _$TransactionCreateDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionCreateDtoImplFromJson(json);

  @override
  final double amount;
  @override
  final bool isIncome;
  @override
  final String sourceOrPurpose;
  @override
  @JsonKey()
  final String note;

  @override
  String toString() {
    return 'TransactionCreateDto(amount: $amount, isIncome: $isIncome, sourceOrPurpose: $sourceOrPurpose, note: $note)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionCreateDtoImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isIncome, isIncome) || other.isIncome == isIncome) &&
            (identical(other.sourceOrPurpose, sourceOrPurpose) ||
                other.sourceOrPurpose == sourceOrPurpose) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, isIncome, sourceOrPurpose, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionCreateDtoImplCopyWith<_$TransactionCreateDtoImpl> get copyWith =>
      __$$TransactionCreateDtoImplCopyWithImpl<_$TransactionCreateDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionCreateDtoImplToJson(
      this,
    );
  }
}

abstract class _TransactionCreateDto implements TransactionCreateDto {
  const factory _TransactionCreateDto(
      {required final double amount,
      required final bool isIncome,
      required final String sourceOrPurpose,
      final String note}) = _$TransactionCreateDtoImpl;

  factory _TransactionCreateDto.fromJson(Map<String, dynamic> json) =
      _$TransactionCreateDtoImpl.fromJson;

  @override
  double get amount;
  @override
  bool get isIncome;
  @override
  String get sourceOrPurpose;
  @override
  String get note;
  @override
  @JsonKey(ignore: true)
  _$$TransactionCreateDtoImplCopyWith<_$TransactionCreateDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
