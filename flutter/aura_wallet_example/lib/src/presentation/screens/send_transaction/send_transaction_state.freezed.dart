// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SendTransactionState {
  SendTransactionStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get isReady => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String get receiveAddress => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  int get fee => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SendTransactionStateCopyWith<SendTransactionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendTransactionStateCopyWith<$Res> {
  factory $SendTransactionStateCopyWith(SendTransactionState value,
          $Res Function(SendTransactionState) then) =
      _$SendTransactionStateCopyWithImpl<$Res, SendTransactionState>;
  @useResult
  $Res call(
      {SendTransactionStatus status,
      String? error,
      bool isReady,
      int amount,
      String receiveAddress,
      String memo,
      int fee});
}

/// @nodoc
class _$SendTransactionStateCopyWithImpl<$Res,
        $Val extends SendTransactionState>
    implements $SendTransactionStateCopyWith<$Res> {
  _$SendTransactionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? isReady = null,
    Object? amount = null,
    Object? receiveAddress = null,
    Object? memo = null,
    Object? fee = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SendTransactionStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      receiveAddress: null == receiveAddress
          ? _value.receiveAddress
          : receiveAddress // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SendTransactionStateCopyWith<$Res>
    implements $SendTransactionStateCopyWith<$Res> {
  factory _$$_SendTransactionStateCopyWith(_$_SendTransactionState value,
          $Res Function(_$_SendTransactionState) then) =
      __$$_SendTransactionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SendTransactionStatus status,
      String? error,
      bool isReady,
      int amount,
      String receiveAddress,
      String memo,
      int fee});
}

/// @nodoc
class __$$_SendTransactionStateCopyWithImpl<$Res>
    extends _$SendTransactionStateCopyWithImpl<$Res, _$_SendTransactionState>
    implements _$$_SendTransactionStateCopyWith<$Res> {
  __$$_SendTransactionStateCopyWithImpl(_$_SendTransactionState _value,
      $Res Function(_$_SendTransactionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? isReady = null,
    Object? amount = null,
    Object? receiveAddress = null,
    Object? memo = null,
    Object? fee = null,
  }) {
    return _then(_$_SendTransactionState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SendTransactionStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      receiveAddress: null == receiveAddress
          ? _value.receiveAddress
          : receiveAddress // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SendTransactionState implements _SendTransactionState {
  const _$_SendTransactionState(
      {this.status = SendTransactionStatus.none,
      this.error,
      this.isReady = false,
      this.amount = 0,
      this.receiveAddress = '',
      this.memo = '',
      this.fee = 100});

  @override
  @JsonKey()
  final SendTransactionStatus status;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isReady;
  @override
  @JsonKey()
  final int amount;
  @override
  @JsonKey()
  final String receiveAddress;
  @override
  @JsonKey()
  final String memo;
  @override
  @JsonKey()
  final int fee;

  @override
  String toString() {
    return 'SendTransactionState(status: $status, error: $error, isReady: $isReady, amount: $amount, receiveAddress: $receiveAddress, memo: $memo, fee: $fee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SendTransactionState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isReady, isReady) || other.isReady == isReady) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.receiveAddress, receiveAddress) ||
                other.receiveAddress == receiveAddress) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, error, isReady, amount, receiveAddress, memo, fee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SendTransactionStateCopyWith<_$_SendTransactionState> get copyWith =>
      __$$_SendTransactionStateCopyWithImpl<_$_SendTransactionState>(
          this, _$identity);
}

abstract class _SendTransactionState implements SendTransactionState {
  const factory _SendTransactionState(
      {final SendTransactionStatus status,
      final String? error,
      final bool isReady,
      final int amount,
      final String receiveAddress,
      final String memo,
      final int fee}) = _$_SendTransactionState;

  @override
  SendTransactionStatus get status;
  @override
  String? get error;
  @override
  bool get isReady;
  @override
  int get amount;
  @override
  String get receiveAddress;
  @override
  String get memo;
  @override
  int get fee;
  @override
  @JsonKey(ignore: true)
  _$$_SendTransactionStateCopyWith<_$_SendTransactionState> get copyWith =>
      throw _privateConstructorUsedError;
}
