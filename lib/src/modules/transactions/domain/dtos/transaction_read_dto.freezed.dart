// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_read_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionReadDto _$TransactionReadDtoFromJson(Map<String, dynamic> json) {
  return _TransactionReadDto.fromJson(json);
}

/// @nodoc
mixin _$TransactionReadDto {
  int get id => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  DateTime? get deleteDate => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  bool get isIncome => throw _privateConstructorUsedError;
  String get sourceOrPurpose => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionReadDtoCopyWith<TransactionReadDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionReadDtoCopyWith<$Res> {
  factory $TransactionReadDtoCopyWith(
          TransactionReadDto value, $Res Function(TransactionReadDto) then) =
      _$TransactionReadDtoCopyWithImpl<$Res, TransactionReadDto>;
  @useResult
  $Res call(
      {int id,
      DateTime createDate,
      DateTime? deleteDate,
      double amount,
      bool isIncome,
      String sourceOrPurpose,
      String note});
}

/// @nodoc
class _$TransactionReadDtoCopyWithImpl<$Res, $Val extends TransactionReadDto>
    implements $TransactionReadDtoCopyWith<$Res> {
  _$TransactionReadDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createDate = null,
    Object? deleteDate = freezed,
    Object? amount = null,
    Object? isIncome = null,
    Object? sourceOrPurpose = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deleteDate: freezed == deleteDate
          ? _value.deleteDate
          : deleteDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$TransactionReadDtoImplCopyWith<$Res>
    implements $TransactionReadDtoCopyWith<$Res> {
  factory _$$TransactionReadDtoImplCopyWith(_$TransactionReadDtoImpl value,
          $Res Function(_$TransactionReadDtoImpl) then) =
      __$$TransactionReadDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createDate,
      DateTime? deleteDate,
      double amount,
      bool isIncome,
      String sourceOrPurpose,
      String note});
}

/// @nodoc
class __$$TransactionReadDtoImplCopyWithImpl<$Res>
    extends _$TransactionReadDtoCopyWithImpl<$Res, _$TransactionReadDtoImpl>
    implements _$$TransactionReadDtoImplCopyWith<$Res> {
  __$$TransactionReadDtoImplCopyWithImpl(_$TransactionReadDtoImpl _value,
      $Res Function(_$TransactionReadDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createDate = null,
    Object? deleteDate = freezed,
    Object? amount = null,
    Object? isIncome = null,
    Object? sourceOrPurpose = null,
    Object? note = null,
  }) {
    return _then(_$TransactionReadDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deleteDate: freezed == deleteDate
          ? _value.deleteDate
          : deleteDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$TransactionReadDtoImpl implements _TransactionReadDto {
  const _$TransactionReadDtoImpl(
      {required this.id,
      required this.createDate,
      this.deleteDate,
      required this.amount,
      required this.isIncome,
      required this.sourceOrPurpose,
      required this.note});

  factory _$TransactionReadDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionReadDtoImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createDate;
  @override
  final DateTime? deleteDate;
  @override
  final double amount;
  @override
  final bool isIncome;
  @override
  final String sourceOrPurpose;
  @override
  final String note;

  @override
  String toString() {
    return 'TransactionReadDto(id: $id, createDate: $createDate, deleteDate: $deleteDate, amount: $amount, isIncome: $isIncome, sourceOrPurpose: $sourceOrPurpose, note: $note)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionReadDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.deleteDate, deleteDate) ||
                other.deleteDate == deleteDate) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isIncome, isIncome) ||
                other.isIncome == isIncome) &&
            (identical(other.sourceOrPurpose, sourceOrPurpose) ||
                other.sourceOrPurpose == sourceOrPurpose) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createDate, deleteDate,
      amount, isIncome, sourceOrPurpose, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionReadDtoImplCopyWith<_$TransactionReadDtoImpl> get copyWith =>
      __$$TransactionReadDtoImplCopyWithImpl<_$TransactionReadDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionReadDtoImplToJson(
      this,
    );
  }
}

abstract class _TransactionReadDto implements TransactionReadDto {
  const factory _TransactionReadDto(
      {required final int id,
      required final DateTime createDate,
      final DateTime? deleteDate,
      required final double amount,
      required final bool isIncome,
      required final String sourceOrPurpose,
      required final String note}) = _$TransactionReadDtoImpl;

  factory _TransactionReadDto.fromJson(Map<String, dynamic> json) =
      _$TransactionReadDtoImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createDate;
  @override
  DateTime? get deleteDate;
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
  _$$TransactionReadDtoImplCopyWith<_$TransactionReadDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
