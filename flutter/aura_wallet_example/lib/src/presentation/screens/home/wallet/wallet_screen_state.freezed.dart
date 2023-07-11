// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalletScreenState {
  WalletScreenStatus get status => throw _privateConstructorUsedError;
  AuraTokenMarket? get token => throw _privateConstructorUsedError;
  List<AuraTransaction> get transactions => throw _privateConstructorUsedError;
  List<AuraBlockData> get blocks => throw _privateConstructorUsedError;
  AuraWalletBalance get walletBalance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletScreenStateCopyWith<WalletScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletScreenStateCopyWith<$Res> {
  factory $WalletScreenStateCopyWith(
          WalletScreenState value, $Res Function(WalletScreenState) then) =
      _$WalletScreenStateCopyWithImpl<$Res, WalletScreenState>;
  @useResult
  $Res call(
      {WalletScreenStatus status,
      AuraTokenMarket? token,
      List<AuraTransaction> transactions,
      List<AuraBlockData> blocks,
      AuraWalletBalance walletBalance});
}

/// @nodoc
class _$WalletScreenStateCopyWithImpl<$Res, $Val extends WalletScreenState>
    implements $WalletScreenStateCopyWith<$Res> {
  _$WalletScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? token = freezed,
    Object? transactions = null,
    Object? blocks = null,
    Object? walletBalance = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WalletScreenStatus,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as AuraTokenMarket?,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<AuraTransaction>,
      blocks: null == blocks
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<AuraBlockData>,
      walletBalance: null == walletBalance
          ? _value.walletBalance
          : walletBalance // ignore: cast_nullable_to_non_nullable
              as AuraWalletBalance,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletScreenStateCopyWith<$Res>
    implements $WalletScreenStateCopyWith<$Res> {
  factory _$$_WalletScreenStateCopyWith(_$_WalletScreenState value,
          $Res Function(_$_WalletScreenState) then) =
      __$$_WalletScreenStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WalletScreenStatus status,
      AuraTokenMarket? token,
      List<AuraTransaction> transactions,
      List<AuraBlockData> blocks,
      AuraWalletBalance walletBalance});
}

/// @nodoc
class __$$_WalletScreenStateCopyWithImpl<$Res>
    extends _$WalletScreenStateCopyWithImpl<$Res, _$_WalletScreenState>
    implements _$$_WalletScreenStateCopyWith<$Res> {
  __$$_WalletScreenStateCopyWithImpl(
      _$_WalletScreenState _value, $Res Function(_$_WalletScreenState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? token = freezed,
    Object? transactions = null,
    Object? blocks = null,
    Object? walletBalance = null,
  }) {
    return _then(_$_WalletScreenState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WalletScreenStatus,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as AuraTokenMarket?,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<AuraTransaction>,
      blocks: null == blocks
          ? _value._blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<AuraBlockData>,
      walletBalance: null == walletBalance
          ? _value.walletBalance
          : walletBalance // ignore: cast_nullable_to_non_nullable
              as AuraWalletBalance,
    ));
  }
}

/// @nodoc

class _$_WalletScreenState implements _WalletScreenState {
  const _$_WalletScreenState(
      {this.status = WalletScreenStatus.loaded,
      this.token,
      final List<AuraTransaction> transactions = const [],
      final List<AuraBlockData> blocks = const [],
      this.walletBalance =
          const AuraWalletBalance(id: '0', amount: '0', deNom: 'Aura')})
      : _transactions = transactions,
        _blocks = blocks;

  @override
  @JsonKey()
  final WalletScreenStatus status;
  @override
  final AuraTokenMarket? token;
  final List<AuraTransaction> _transactions;
  @override
  @JsonKey()
  List<AuraTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final List<AuraBlockData> _blocks;
  @override
  @JsonKey()
  List<AuraBlockData> get blocks {
    if (_blocks is EqualUnmodifiableListView) return _blocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blocks);
  }

  @override
  @JsonKey()
  final AuraWalletBalance walletBalance;

  @override
  String toString() {
    return 'WalletScreenState(status: $status, token: $token, transactions: $transactions, blocks: $blocks, walletBalance: $walletBalance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletScreenState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            const DeepCollectionEquality().equals(other._blocks, _blocks) &&
            (identical(other.walletBalance, walletBalance) ||
                other.walletBalance == walletBalance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      token,
      const DeepCollectionEquality().hash(_transactions),
      const DeepCollectionEquality().hash(_blocks),
      walletBalance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletScreenStateCopyWith<_$_WalletScreenState> get copyWith =>
      __$$_WalletScreenStateCopyWithImpl<_$_WalletScreenState>(
          this, _$identity);
}

abstract class _WalletScreenState implements WalletScreenState {
  const factory _WalletScreenState(
      {final WalletScreenStatus status,
      final AuraTokenMarket? token,
      final List<AuraTransaction> transactions,
      final List<AuraBlockData> blocks,
      final AuraWalletBalance walletBalance}) = _$_WalletScreenState;

  @override
  WalletScreenStatus get status;
  @override
  AuraTokenMarket? get token;
  @override
  List<AuraTransaction> get transactions;
  @override
  List<AuraBlockData> get blocks;
  @override
  AuraWalletBalance get walletBalance;
  @override
  @JsonKey(ignore: true)
  _$$_WalletScreenStateCopyWith<_$_WalletScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}
