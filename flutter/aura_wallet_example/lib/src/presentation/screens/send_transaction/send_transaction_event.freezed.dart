// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_transaction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SendTransactionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet auraWallet) submit,
    required TResult Function(String address) addressChange,
    required TResult Function(int amount) amountChange,
    required TResult Function(String memo) memoChange,
    required TResult Function(int fee) feeChange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet auraWallet)? submit,
    TResult? Function(String address)? addressChange,
    TResult? Function(int amount)? amountChange,
    TResult? Function(String memo)? memoChange,
    TResult? Function(int fee)? feeChange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet auraWallet)? submit,
    TResult Function(String address)? addressChange,
    TResult Function(int amount)? amountChange,
    TResult Function(String memo)? memoChange,
    TResult Function(int fee)? feeChange,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SendTransactionSubmitEvent value) submit,
    required TResult Function(SendTransactionOnAddressChangeEvent value)
        addressChange,
    required TResult Function(SendTransactionOnAmountChangeEvent value)
        amountChange,
    required TResult Function(SendTransactionOnMemoChangeEvent value)
        memoChange,
    required TResult Function(SendTransactionOnFeeChangeEvent value) feeChange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionSubmitEvent value)? submit,
    TResult? Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult? Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult? Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult? Function(SendTransactionOnFeeChangeEvent value)? feeChange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionSubmitEvent value)? submit,
    TResult Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult Function(SendTransactionOnFeeChangeEvent value)? feeChange,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendTransactionEventCopyWith<$Res> {
  factory $SendTransactionEventCopyWith(SendTransactionEvent value,
          $Res Function(SendTransactionEvent) then) =
      _$SendTransactionEventCopyWithImpl<$Res, SendTransactionEvent>;
}

/// @nodoc
class _$SendTransactionEventCopyWithImpl<$Res,
        $Val extends SendTransactionEvent>
    implements $SendTransactionEventCopyWith<$Res> {
  _$SendTransactionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SendTransactionSubmitEventCopyWith<$Res> {
  factory _$$SendTransactionSubmitEventCopyWith(
          _$SendTransactionSubmitEvent value,
          $Res Function(_$SendTransactionSubmitEvent) then) =
      __$$SendTransactionSubmitEventCopyWithImpl<$Res>;
  @useResult
  $Res call({AuraWallet auraWallet});
}

/// @nodoc
class __$$SendTransactionSubmitEventCopyWithImpl<$Res>
    extends _$SendTransactionEventCopyWithImpl<$Res,
        _$SendTransactionSubmitEvent>
    implements _$$SendTransactionSubmitEventCopyWith<$Res> {
  __$$SendTransactionSubmitEventCopyWithImpl(
      _$SendTransactionSubmitEvent _value,
      $Res Function(_$SendTransactionSubmitEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? auraWallet = null,
  }) {
    return _then(_$SendTransactionSubmitEvent(
      auraWallet: null == auraWallet
          ? _value.auraWallet
          : auraWallet // ignore: cast_nullable_to_non_nullable
              as AuraWallet,
    ));
  }
}

/// @nodoc

class _$SendTransactionSubmitEvent implements SendTransactionSubmitEvent {
  const _$SendTransactionSubmitEvent({required this.auraWallet});

  @override
  final AuraWallet auraWallet;

  @override
  String toString() {
    return 'SendTransactionEvent.submit(auraWallet: $auraWallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionSubmitEvent &&
            (identical(other.auraWallet, auraWallet) ||
                other.auraWallet == auraWallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, auraWallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionSubmitEventCopyWith<_$SendTransactionSubmitEvent>
      get copyWith => __$$SendTransactionSubmitEventCopyWithImpl<
          _$SendTransactionSubmitEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet auraWallet) submit,
    required TResult Function(String address) addressChange,
    required TResult Function(int amount) amountChange,
    required TResult Function(String memo) memoChange,
    required TResult Function(int fee) feeChange,
  }) {
    return submit(auraWallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet auraWallet)? submit,
    TResult? Function(String address)? addressChange,
    TResult? Function(int amount)? amountChange,
    TResult? Function(String memo)? memoChange,
    TResult? Function(int fee)? feeChange,
  }) {
    return submit?.call(auraWallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet auraWallet)? submit,
    TResult Function(String address)? addressChange,
    TResult Function(int amount)? amountChange,
    TResult Function(String memo)? memoChange,
    TResult Function(int fee)? feeChange,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(auraWallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SendTransactionSubmitEvent value) submit,
    required TResult Function(SendTransactionOnAddressChangeEvent value)
        addressChange,
    required TResult Function(SendTransactionOnAmountChangeEvent value)
        amountChange,
    required TResult Function(SendTransactionOnMemoChangeEvent value)
        memoChange,
    required TResult Function(SendTransactionOnFeeChangeEvent value) feeChange,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionSubmitEvent value)? submit,
    TResult? Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult? Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult? Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult? Function(SendTransactionOnFeeChangeEvent value)? feeChange,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionSubmitEvent value)? submit,
    TResult Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult Function(SendTransactionOnFeeChangeEvent value)? feeChange,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class SendTransactionSubmitEvent implements SendTransactionEvent {
  const factory SendTransactionSubmitEvent(
      {required final AuraWallet auraWallet}) = _$SendTransactionSubmitEvent;

  AuraWallet get auraWallet;
  @JsonKey(ignore: true)
  _$$SendTransactionSubmitEventCopyWith<_$SendTransactionSubmitEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTransactionOnAddressChangeEventCopyWith<$Res> {
  factory _$$SendTransactionOnAddressChangeEventCopyWith(
          _$SendTransactionOnAddressChangeEvent value,
          $Res Function(_$SendTransactionOnAddressChangeEvent) then) =
      __$$SendTransactionOnAddressChangeEventCopyWithImpl<$Res>;
  @useResult
  $Res call({String address});
}

/// @nodoc
class __$$SendTransactionOnAddressChangeEventCopyWithImpl<$Res>
    extends _$SendTransactionEventCopyWithImpl<$Res,
        _$SendTransactionOnAddressChangeEvent>
    implements _$$SendTransactionOnAddressChangeEventCopyWith<$Res> {
  __$$SendTransactionOnAddressChangeEventCopyWithImpl(
      _$SendTransactionOnAddressChangeEvent _value,
      $Res Function(_$SendTransactionOnAddressChangeEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$SendTransactionOnAddressChangeEvent(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendTransactionOnAddressChangeEvent
    implements SendTransactionOnAddressChangeEvent {
  const _$SendTransactionOnAddressChangeEvent({required this.address});

  @override
  final String address;

  @override
  String toString() {
    return 'SendTransactionEvent.addressChange(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionOnAddressChangeEvent &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionOnAddressChangeEventCopyWith<
          _$SendTransactionOnAddressChangeEvent>
      get copyWith => __$$SendTransactionOnAddressChangeEventCopyWithImpl<
          _$SendTransactionOnAddressChangeEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet auraWallet) submit,
    required TResult Function(String address) addressChange,
    required TResult Function(int amount) amountChange,
    required TResult Function(String memo) memoChange,
    required TResult Function(int fee) feeChange,
  }) {
    return addressChange(address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet auraWallet)? submit,
    TResult? Function(String address)? addressChange,
    TResult? Function(int amount)? amountChange,
    TResult? Function(String memo)? memoChange,
    TResult? Function(int fee)? feeChange,
  }) {
    return addressChange?.call(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet auraWallet)? submit,
    TResult Function(String address)? addressChange,
    TResult Function(int amount)? amountChange,
    TResult Function(String memo)? memoChange,
    TResult Function(int fee)? feeChange,
    required TResult orElse(),
  }) {
    if (addressChange != null) {
      return addressChange(address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SendTransactionSubmitEvent value) submit,
    required TResult Function(SendTransactionOnAddressChangeEvent value)
        addressChange,
    required TResult Function(SendTransactionOnAmountChangeEvent value)
        amountChange,
    required TResult Function(SendTransactionOnMemoChangeEvent value)
        memoChange,
    required TResult Function(SendTransactionOnFeeChangeEvent value) feeChange,
  }) {
    return addressChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionSubmitEvent value)? submit,
    TResult? Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult? Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult? Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult? Function(SendTransactionOnFeeChangeEvent value)? feeChange,
  }) {
    return addressChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionSubmitEvent value)? submit,
    TResult Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult Function(SendTransactionOnFeeChangeEvent value)? feeChange,
    required TResult orElse(),
  }) {
    if (addressChange != null) {
      return addressChange(this);
    }
    return orElse();
  }
}

abstract class SendTransactionOnAddressChangeEvent
    implements SendTransactionEvent {
  const factory SendTransactionOnAddressChangeEvent(
      {required final String address}) = _$SendTransactionOnAddressChangeEvent;

  String get address;
  @JsonKey(ignore: true)
  _$$SendTransactionOnAddressChangeEventCopyWith<
          _$SendTransactionOnAddressChangeEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTransactionOnAmountChangeEventCopyWith<$Res> {
  factory _$$SendTransactionOnAmountChangeEventCopyWith(
          _$SendTransactionOnAmountChangeEvent value,
          $Res Function(_$SendTransactionOnAmountChangeEvent) then) =
      __$$SendTransactionOnAmountChangeEventCopyWithImpl<$Res>;
  @useResult
  $Res call({int amount});
}

/// @nodoc
class __$$SendTransactionOnAmountChangeEventCopyWithImpl<$Res>
    extends _$SendTransactionEventCopyWithImpl<$Res,
        _$SendTransactionOnAmountChangeEvent>
    implements _$$SendTransactionOnAmountChangeEventCopyWith<$Res> {
  __$$SendTransactionOnAmountChangeEventCopyWithImpl(
      _$SendTransactionOnAmountChangeEvent _value,
      $Res Function(_$SendTransactionOnAmountChangeEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_$SendTransactionOnAmountChangeEvent(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SendTransactionOnAmountChangeEvent
    implements SendTransactionOnAmountChangeEvent {
  const _$SendTransactionOnAmountChangeEvent({required this.amount});

  @override
  final int amount;

  @override
  String toString() {
    return 'SendTransactionEvent.amountChange(amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionOnAmountChangeEvent &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionOnAmountChangeEventCopyWith<
          _$SendTransactionOnAmountChangeEvent>
      get copyWith => __$$SendTransactionOnAmountChangeEventCopyWithImpl<
          _$SendTransactionOnAmountChangeEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet auraWallet) submit,
    required TResult Function(String address) addressChange,
    required TResult Function(int amount) amountChange,
    required TResult Function(String memo) memoChange,
    required TResult Function(int fee) feeChange,
  }) {
    return amountChange(amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet auraWallet)? submit,
    TResult? Function(String address)? addressChange,
    TResult? Function(int amount)? amountChange,
    TResult? Function(String memo)? memoChange,
    TResult? Function(int fee)? feeChange,
  }) {
    return amountChange?.call(amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet auraWallet)? submit,
    TResult Function(String address)? addressChange,
    TResult Function(int amount)? amountChange,
    TResult Function(String memo)? memoChange,
    TResult Function(int fee)? feeChange,
    required TResult orElse(),
  }) {
    if (amountChange != null) {
      return amountChange(amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SendTransactionSubmitEvent value) submit,
    required TResult Function(SendTransactionOnAddressChangeEvent value)
        addressChange,
    required TResult Function(SendTransactionOnAmountChangeEvent value)
        amountChange,
    required TResult Function(SendTransactionOnMemoChangeEvent value)
        memoChange,
    required TResult Function(SendTransactionOnFeeChangeEvent value) feeChange,
  }) {
    return amountChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionSubmitEvent value)? submit,
    TResult? Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult? Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult? Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult? Function(SendTransactionOnFeeChangeEvent value)? feeChange,
  }) {
    return amountChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionSubmitEvent value)? submit,
    TResult Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult Function(SendTransactionOnFeeChangeEvent value)? feeChange,
    required TResult orElse(),
  }) {
    if (amountChange != null) {
      return amountChange(this);
    }
    return orElse();
  }
}

abstract class SendTransactionOnAmountChangeEvent
    implements SendTransactionEvent {
  const factory SendTransactionOnAmountChangeEvent(
      {required final int amount}) = _$SendTransactionOnAmountChangeEvent;

  int get amount;
  @JsonKey(ignore: true)
  _$$SendTransactionOnAmountChangeEventCopyWith<
          _$SendTransactionOnAmountChangeEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTransactionOnMemoChangeEventCopyWith<$Res> {
  factory _$$SendTransactionOnMemoChangeEventCopyWith(
          _$SendTransactionOnMemoChangeEvent value,
          $Res Function(_$SendTransactionOnMemoChangeEvent) then) =
      __$$SendTransactionOnMemoChangeEventCopyWithImpl<$Res>;
  @useResult
  $Res call({String memo});
}

/// @nodoc
class __$$SendTransactionOnMemoChangeEventCopyWithImpl<$Res>
    extends _$SendTransactionEventCopyWithImpl<$Res,
        _$SendTransactionOnMemoChangeEvent>
    implements _$$SendTransactionOnMemoChangeEventCopyWith<$Res> {
  __$$SendTransactionOnMemoChangeEventCopyWithImpl(
      _$SendTransactionOnMemoChangeEvent _value,
      $Res Function(_$SendTransactionOnMemoChangeEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memo = null,
  }) {
    return _then(_$SendTransactionOnMemoChangeEvent(
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendTransactionOnMemoChangeEvent
    implements SendTransactionOnMemoChangeEvent {
  const _$SendTransactionOnMemoChangeEvent({required this.memo});

  @override
  final String memo;

  @override
  String toString() {
    return 'SendTransactionEvent.memoChange(memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionOnMemoChangeEvent &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionOnMemoChangeEventCopyWith<
          _$SendTransactionOnMemoChangeEvent>
      get copyWith => __$$SendTransactionOnMemoChangeEventCopyWithImpl<
          _$SendTransactionOnMemoChangeEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet auraWallet) submit,
    required TResult Function(String address) addressChange,
    required TResult Function(int amount) amountChange,
    required TResult Function(String memo) memoChange,
    required TResult Function(int fee) feeChange,
  }) {
    return memoChange(memo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet auraWallet)? submit,
    TResult? Function(String address)? addressChange,
    TResult? Function(int amount)? amountChange,
    TResult? Function(String memo)? memoChange,
    TResult? Function(int fee)? feeChange,
  }) {
    return memoChange?.call(memo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet auraWallet)? submit,
    TResult Function(String address)? addressChange,
    TResult Function(int amount)? amountChange,
    TResult Function(String memo)? memoChange,
    TResult Function(int fee)? feeChange,
    required TResult orElse(),
  }) {
    if (memoChange != null) {
      return memoChange(memo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SendTransactionSubmitEvent value) submit,
    required TResult Function(SendTransactionOnAddressChangeEvent value)
        addressChange,
    required TResult Function(SendTransactionOnAmountChangeEvent value)
        amountChange,
    required TResult Function(SendTransactionOnMemoChangeEvent value)
        memoChange,
    required TResult Function(SendTransactionOnFeeChangeEvent value) feeChange,
  }) {
    return memoChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionSubmitEvent value)? submit,
    TResult? Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult? Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult? Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult? Function(SendTransactionOnFeeChangeEvent value)? feeChange,
  }) {
    return memoChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionSubmitEvent value)? submit,
    TResult Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult Function(SendTransactionOnFeeChangeEvent value)? feeChange,
    required TResult orElse(),
  }) {
    if (memoChange != null) {
      return memoChange(this);
    }
    return orElse();
  }
}

abstract class SendTransactionOnMemoChangeEvent
    implements SendTransactionEvent {
  const factory SendTransactionOnMemoChangeEvent({required final String memo}) =
      _$SendTransactionOnMemoChangeEvent;

  String get memo;
  @JsonKey(ignore: true)
  _$$SendTransactionOnMemoChangeEventCopyWith<
          _$SendTransactionOnMemoChangeEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTransactionOnFeeChangeEventCopyWith<$Res> {
  factory _$$SendTransactionOnFeeChangeEventCopyWith(
          _$SendTransactionOnFeeChangeEvent value,
          $Res Function(_$SendTransactionOnFeeChangeEvent) then) =
      __$$SendTransactionOnFeeChangeEventCopyWithImpl<$Res>;
  @useResult
  $Res call({int fee});
}

/// @nodoc
class __$$SendTransactionOnFeeChangeEventCopyWithImpl<$Res>
    extends _$SendTransactionEventCopyWithImpl<$Res,
        _$SendTransactionOnFeeChangeEvent>
    implements _$$SendTransactionOnFeeChangeEventCopyWith<$Res> {
  __$$SendTransactionOnFeeChangeEventCopyWithImpl(
      _$SendTransactionOnFeeChangeEvent _value,
      $Res Function(_$SendTransactionOnFeeChangeEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
  }) {
    return _then(_$SendTransactionOnFeeChangeEvent(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SendTransactionOnFeeChangeEvent
    implements SendTransactionOnFeeChangeEvent {
  const _$SendTransactionOnFeeChangeEvent({required this.fee});

  @override
  final int fee;

  @override
  String toString() {
    return 'SendTransactionEvent.feeChange(fee: $fee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionOnFeeChangeEvent &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionOnFeeChangeEventCopyWith<_$SendTransactionOnFeeChangeEvent>
      get copyWith => __$$SendTransactionOnFeeChangeEventCopyWithImpl<
          _$SendTransactionOnFeeChangeEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet auraWallet) submit,
    required TResult Function(String address) addressChange,
    required TResult Function(int amount) amountChange,
    required TResult Function(String memo) memoChange,
    required TResult Function(int fee) feeChange,
  }) {
    return feeChange(fee);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet auraWallet)? submit,
    TResult? Function(String address)? addressChange,
    TResult? Function(int amount)? amountChange,
    TResult? Function(String memo)? memoChange,
    TResult? Function(int fee)? feeChange,
  }) {
    return feeChange?.call(fee);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet auraWallet)? submit,
    TResult Function(String address)? addressChange,
    TResult Function(int amount)? amountChange,
    TResult Function(String memo)? memoChange,
    TResult Function(int fee)? feeChange,
    required TResult orElse(),
  }) {
    if (feeChange != null) {
      return feeChange(fee);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SendTransactionSubmitEvent value) submit,
    required TResult Function(SendTransactionOnAddressChangeEvent value)
        addressChange,
    required TResult Function(SendTransactionOnAmountChangeEvent value)
        amountChange,
    required TResult Function(SendTransactionOnMemoChangeEvent value)
        memoChange,
    required TResult Function(SendTransactionOnFeeChangeEvent value) feeChange,
  }) {
    return feeChange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionSubmitEvent value)? submit,
    TResult? Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult? Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult? Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult? Function(SendTransactionOnFeeChangeEvent value)? feeChange,
  }) {
    return feeChange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionSubmitEvent value)? submit,
    TResult Function(SendTransactionOnAddressChangeEvent value)? addressChange,
    TResult Function(SendTransactionOnAmountChangeEvent value)? amountChange,
    TResult Function(SendTransactionOnMemoChangeEvent value)? memoChange,
    TResult Function(SendTransactionOnFeeChangeEvent value)? feeChange,
    required TResult orElse(),
  }) {
    if (feeChange != null) {
      return feeChange(this);
    }
    return orElse();
  }
}

abstract class SendTransactionOnFeeChangeEvent implements SendTransactionEvent {
  const factory SendTransactionOnFeeChangeEvent({required final int fee}) =
      _$SendTransactionOnFeeChangeEvent;

  int get fee;
  @JsonKey(ignore: true)
  _$$SendTransactionOnFeeChangeEventCopyWith<_$SendTransactionOnFeeChangeEvent>
      get copyWith => throw _privateConstructorUsedError;
}
