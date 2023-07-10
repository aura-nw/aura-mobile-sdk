// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_screen_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalletScreenEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet wallet) starting,
    required TResult Function(String address) refreshTransaction,
    required TResult Function() refreshBlock,
    required TResult Function(AuraWallet wallet) refreshBalance,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet wallet)? starting,
    TResult? Function(String address)? refreshTransaction,
    TResult? Function()? refreshBlock,
    TResult? Function(AuraWallet wallet)? refreshBalance,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet wallet)? starting,
    TResult Function(String address)? refreshTransaction,
    TResult Function()? refreshBlock,
    TResult Function(AuraWallet wallet)? refreshBalance,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletScreenStartingEvent value) starting,
    required TResult Function(WalletScreenRefreshTransactionEvent value)
        refreshTransaction,
    required TResult Function(WalletScreenRefreshBlockEvent value) refreshBlock,
    required TResult Function(WalletScreenRefreshBalanceEvent value)
        refreshBalance,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletScreenStartingEvent value)? starting,
    TResult? Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult? Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult? Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletScreenStartingEvent value)? starting,
    TResult Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletScreenEventCopyWith<$Res> {
  factory $WalletScreenEventCopyWith(
          WalletScreenEvent value, $Res Function(WalletScreenEvent) then) =
      _$WalletScreenEventCopyWithImpl<$Res, WalletScreenEvent>;
}

/// @nodoc
class _$WalletScreenEventCopyWithImpl<$Res, $Val extends WalletScreenEvent>
    implements $WalletScreenEventCopyWith<$Res> {
  _$WalletScreenEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$WalletScreenStartingEventCopyWith<$Res> {
  factory _$$WalletScreenStartingEventCopyWith(
          _$WalletScreenStartingEvent value,
          $Res Function(_$WalletScreenStartingEvent) then) =
      __$$WalletScreenStartingEventCopyWithImpl<$Res>;
  @useResult
  $Res call({AuraWallet wallet});
}

/// @nodoc
class __$$WalletScreenStartingEventCopyWithImpl<$Res>
    extends _$WalletScreenEventCopyWithImpl<$Res, _$WalletScreenStartingEvent>
    implements _$$WalletScreenStartingEventCopyWith<$Res> {
  __$$WalletScreenStartingEventCopyWithImpl(_$WalletScreenStartingEvent _value,
      $Res Function(_$WalletScreenStartingEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = null,
  }) {
    return _then(_$WalletScreenStartingEvent(
      null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as AuraWallet,
    ));
  }
}

/// @nodoc

class _$WalletScreenStartingEvent implements WalletScreenStartingEvent {
  const _$WalletScreenStartingEvent(this.wallet);

  @override
  final AuraWallet wallet;

  @override
  String toString() {
    return 'WalletScreenEvent.starting(wallet: $wallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletScreenStartingEvent &&
            (identical(other.wallet, wallet) || other.wallet == wallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletScreenStartingEventCopyWith<_$WalletScreenStartingEvent>
      get copyWith => __$$WalletScreenStartingEventCopyWithImpl<
          _$WalletScreenStartingEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet wallet) starting,
    required TResult Function(String address) refreshTransaction,
    required TResult Function() refreshBlock,
    required TResult Function(AuraWallet wallet) refreshBalance,
  }) {
    return starting(wallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet wallet)? starting,
    TResult? Function(String address)? refreshTransaction,
    TResult? Function()? refreshBlock,
    TResult? Function(AuraWallet wallet)? refreshBalance,
  }) {
    return starting?.call(wallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet wallet)? starting,
    TResult Function(String address)? refreshTransaction,
    TResult Function()? refreshBlock,
    TResult Function(AuraWallet wallet)? refreshBalance,
    required TResult orElse(),
  }) {
    if (starting != null) {
      return starting(wallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletScreenStartingEvent value) starting,
    required TResult Function(WalletScreenRefreshTransactionEvent value)
        refreshTransaction,
    required TResult Function(WalletScreenRefreshBlockEvent value) refreshBlock,
    required TResult Function(WalletScreenRefreshBalanceEvent value)
        refreshBalance,
  }) {
    return starting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletScreenStartingEvent value)? starting,
    TResult? Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult? Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult? Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
  }) {
    return starting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletScreenStartingEvent value)? starting,
    TResult Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
    required TResult orElse(),
  }) {
    if (starting != null) {
      return starting(this);
    }
    return orElse();
  }
}

abstract class WalletScreenStartingEvent implements WalletScreenEvent {
  const factory WalletScreenStartingEvent(final AuraWallet wallet) =
      _$WalletScreenStartingEvent;

  AuraWallet get wallet;
  @JsonKey(ignore: true)
  _$$WalletScreenStartingEventCopyWith<_$WalletScreenStartingEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WalletScreenRefreshTransactionEventCopyWith<$Res> {
  factory _$$WalletScreenRefreshTransactionEventCopyWith(
          _$WalletScreenRefreshTransactionEvent value,
          $Res Function(_$WalletScreenRefreshTransactionEvent) then) =
      __$$WalletScreenRefreshTransactionEventCopyWithImpl<$Res>;
  @useResult
  $Res call({String address});
}

/// @nodoc
class __$$WalletScreenRefreshTransactionEventCopyWithImpl<$Res>
    extends _$WalletScreenEventCopyWithImpl<$Res,
        _$WalletScreenRefreshTransactionEvent>
    implements _$$WalletScreenRefreshTransactionEventCopyWith<$Res> {
  __$$WalletScreenRefreshTransactionEventCopyWithImpl(
      _$WalletScreenRefreshTransactionEvent _value,
      $Res Function(_$WalletScreenRefreshTransactionEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$WalletScreenRefreshTransactionEvent(
      null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WalletScreenRefreshTransactionEvent
    implements WalletScreenRefreshTransactionEvent {
  const _$WalletScreenRefreshTransactionEvent(this.address);

  @override
  final String address;

  @override
  String toString() {
    return 'WalletScreenEvent.refreshTransaction(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletScreenRefreshTransactionEvent &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletScreenRefreshTransactionEventCopyWith<
          _$WalletScreenRefreshTransactionEvent>
      get copyWith => __$$WalletScreenRefreshTransactionEventCopyWithImpl<
          _$WalletScreenRefreshTransactionEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet wallet) starting,
    required TResult Function(String address) refreshTransaction,
    required TResult Function() refreshBlock,
    required TResult Function(AuraWallet wallet) refreshBalance,
  }) {
    return refreshTransaction(address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet wallet)? starting,
    TResult? Function(String address)? refreshTransaction,
    TResult? Function()? refreshBlock,
    TResult? Function(AuraWallet wallet)? refreshBalance,
  }) {
    return refreshTransaction?.call(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet wallet)? starting,
    TResult Function(String address)? refreshTransaction,
    TResult Function()? refreshBlock,
    TResult Function(AuraWallet wallet)? refreshBalance,
    required TResult orElse(),
  }) {
    if (refreshTransaction != null) {
      return refreshTransaction(address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletScreenStartingEvent value) starting,
    required TResult Function(WalletScreenRefreshTransactionEvent value)
        refreshTransaction,
    required TResult Function(WalletScreenRefreshBlockEvent value) refreshBlock,
    required TResult Function(WalletScreenRefreshBalanceEvent value)
        refreshBalance,
  }) {
    return refreshTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletScreenStartingEvent value)? starting,
    TResult? Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult? Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult? Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
  }) {
    return refreshTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletScreenStartingEvent value)? starting,
    TResult Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
    required TResult orElse(),
  }) {
    if (refreshTransaction != null) {
      return refreshTransaction(this);
    }
    return orElse();
  }
}

abstract class WalletScreenRefreshTransactionEvent
    implements WalletScreenEvent {
  const factory WalletScreenRefreshTransactionEvent(final String address) =
      _$WalletScreenRefreshTransactionEvent;

  String get address;
  @JsonKey(ignore: true)
  _$$WalletScreenRefreshTransactionEventCopyWith<
          _$WalletScreenRefreshTransactionEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WalletScreenRefreshBlockEventCopyWith<$Res> {
  factory _$$WalletScreenRefreshBlockEventCopyWith(
          _$WalletScreenRefreshBlockEvent value,
          $Res Function(_$WalletScreenRefreshBlockEvent) then) =
      __$$WalletScreenRefreshBlockEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WalletScreenRefreshBlockEventCopyWithImpl<$Res>
    extends _$WalletScreenEventCopyWithImpl<$Res,
        _$WalletScreenRefreshBlockEvent>
    implements _$$WalletScreenRefreshBlockEventCopyWith<$Res> {
  __$$WalletScreenRefreshBlockEventCopyWithImpl(
      _$WalletScreenRefreshBlockEvent _value,
      $Res Function(_$WalletScreenRefreshBlockEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WalletScreenRefreshBlockEvent implements WalletScreenRefreshBlockEvent {
  const _$WalletScreenRefreshBlockEvent();

  @override
  String toString() {
    return 'WalletScreenEvent.refreshBlock()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletScreenRefreshBlockEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet wallet) starting,
    required TResult Function(String address) refreshTransaction,
    required TResult Function() refreshBlock,
    required TResult Function(AuraWallet wallet) refreshBalance,
  }) {
    return refreshBlock();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet wallet)? starting,
    TResult? Function(String address)? refreshTransaction,
    TResult? Function()? refreshBlock,
    TResult? Function(AuraWallet wallet)? refreshBalance,
  }) {
    return refreshBlock?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet wallet)? starting,
    TResult Function(String address)? refreshTransaction,
    TResult Function()? refreshBlock,
    TResult Function(AuraWallet wallet)? refreshBalance,
    required TResult orElse(),
  }) {
    if (refreshBlock != null) {
      return refreshBlock();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletScreenStartingEvent value) starting,
    required TResult Function(WalletScreenRefreshTransactionEvent value)
        refreshTransaction,
    required TResult Function(WalletScreenRefreshBlockEvent value) refreshBlock,
    required TResult Function(WalletScreenRefreshBalanceEvent value)
        refreshBalance,
  }) {
    return refreshBlock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletScreenStartingEvent value)? starting,
    TResult? Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult? Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult? Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
  }) {
    return refreshBlock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletScreenStartingEvent value)? starting,
    TResult Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
    required TResult orElse(),
  }) {
    if (refreshBlock != null) {
      return refreshBlock(this);
    }
    return orElse();
  }
}

abstract class WalletScreenRefreshBlockEvent implements WalletScreenEvent {
  const factory WalletScreenRefreshBlockEvent() =
      _$WalletScreenRefreshBlockEvent;
}

/// @nodoc
abstract class _$$WalletScreenRefreshBalanceEventCopyWith<$Res> {
  factory _$$WalletScreenRefreshBalanceEventCopyWith(
          _$WalletScreenRefreshBalanceEvent value,
          $Res Function(_$WalletScreenRefreshBalanceEvent) then) =
      __$$WalletScreenRefreshBalanceEventCopyWithImpl<$Res>;
  @useResult
  $Res call({AuraWallet wallet});
}

/// @nodoc
class __$$WalletScreenRefreshBalanceEventCopyWithImpl<$Res>
    extends _$WalletScreenEventCopyWithImpl<$Res,
        _$WalletScreenRefreshBalanceEvent>
    implements _$$WalletScreenRefreshBalanceEventCopyWith<$Res> {
  __$$WalletScreenRefreshBalanceEventCopyWithImpl(
      _$WalletScreenRefreshBalanceEvent _value,
      $Res Function(_$WalletScreenRefreshBalanceEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = null,
  }) {
    return _then(_$WalletScreenRefreshBalanceEvent(
      null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as AuraWallet,
    ));
  }
}

/// @nodoc

class _$WalletScreenRefreshBalanceEvent
    implements WalletScreenRefreshBalanceEvent {
  const _$WalletScreenRefreshBalanceEvent(this.wallet);

  @override
  final AuraWallet wallet;

  @override
  String toString() {
    return 'WalletScreenEvent.refreshBalance(wallet: $wallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletScreenRefreshBalanceEvent &&
            (identical(other.wallet, wallet) || other.wallet == wallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletScreenRefreshBalanceEventCopyWith<_$WalletScreenRefreshBalanceEvent>
      get copyWith => __$$WalletScreenRefreshBalanceEventCopyWithImpl<
          _$WalletScreenRefreshBalanceEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuraWallet wallet) starting,
    required TResult Function(String address) refreshTransaction,
    required TResult Function() refreshBlock,
    required TResult Function(AuraWallet wallet) refreshBalance,
  }) {
    return refreshBalance(wallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuraWallet wallet)? starting,
    TResult? Function(String address)? refreshTransaction,
    TResult? Function()? refreshBlock,
    TResult? Function(AuraWallet wallet)? refreshBalance,
  }) {
    return refreshBalance?.call(wallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuraWallet wallet)? starting,
    TResult Function(String address)? refreshTransaction,
    TResult Function()? refreshBlock,
    TResult Function(AuraWallet wallet)? refreshBalance,
    required TResult orElse(),
  }) {
    if (refreshBalance != null) {
      return refreshBalance(wallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletScreenStartingEvent value) starting,
    required TResult Function(WalletScreenRefreshTransactionEvent value)
        refreshTransaction,
    required TResult Function(WalletScreenRefreshBlockEvent value) refreshBlock,
    required TResult Function(WalletScreenRefreshBalanceEvent value)
        refreshBalance,
  }) {
    return refreshBalance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletScreenStartingEvent value)? starting,
    TResult? Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult? Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult? Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
  }) {
    return refreshBalance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletScreenStartingEvent value)? starting,
    TResult Function(WalletScreenRefreshTransactionEvent value)?
        refreshTransaction,
    TResult Function(WalletScreenRefreshBlockEvent value)? refreshBlock,
    TResult Function(WalletScreenRefreshBalanceEvent value)? refreshBalance,
    required TResult orElse(),
  }) {
    if (refreshBalance != null) {
      return refreshBalance(this);
    }
    return orElse();
  }
}

abstract class WalletScreenRefreshBalanceEvent implements WalletScreenEvent {
  const factory WalletScreenRefreshBalanceEvent(final AuraWallet wallet) =
      _$WalletScreenRefreshBalanceEvent;

  AuraWallet get wallet;
  @JsonKey(ignore: true)
  _$$WalletScreenRefreshBalanceEventCopyWith<_$WalletScreenRefreshBalanceEvent>
      get copyWith => throw _privateConstructorUsedError;
}
