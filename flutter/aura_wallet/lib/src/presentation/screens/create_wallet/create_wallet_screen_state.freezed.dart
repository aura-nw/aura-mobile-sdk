// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_wallet_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateWalletScreenState {
  CreateWalletScreenStatus get status => throw _privateConstructorUsedError;
  AuraFullInfoWallet? get auraFullInfoWallet =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateWalletScreenStateCopyWith<CreateWalletScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateWalletScreenStateCopyWith<$Res> {
  factory $CreateWalletScreenStateCopyWith(CreateWalletScreenState value,
          $Res Function(CreateWalletScreenState) then) =
      _$CreateWalletScreenStateCopyWithImpl<$Res, CreateWalletScreenState>;
  @useResult
  $Res call(
      {CreateWalletScreenStatus status,
      AuraFullInfoWallet? auraFullInfoWallet});
}

/// @nodoc
class _$CreateWalletScreenStateCopyWithImpl<$Res,
        $Val extends CreateWalletScreenState>
    implements $CreateWalletScreenStateCopyWith<$Res> {
  _$CreateWalletScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? auraFullInfoWallet = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateWalletScreenStatus,
      auraFullInfoWallet: freezed == auraFullInfoWallet
          ? _value.auraFullInfoWallet
          : auraFullInfoWallet // ignore: cast_nullable_to_non_nullable
              as AuraFullInfoWallet?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateWalletScreenStateCopyWith<$Res>
    implements $CreateWalletScreenStateCopyWith<$Res> {
  factory _$$_CreateWalletScreenStateCopyWith(_$_CreateWalletScreenState value,
          $Res Function(_$_CreateWalletScreenState) then) =
      __$$_CreateWalletScreenStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CreateWalletScreenStatus status,
      AuraFullInfoWallet? auraFullInfoWallet});
}

/// @nodoc
class __$$_CreateWalletScreenStateCopyWithImpl<$Res>
    extends _$CreateWalletScreenStateCopyWithImpl<$Res,
        _$_CreateWalletScreenState>
    implements _$$_CreateWalletScreenStateCopyWith<$Res> {
  __$$_CreateWalletScreenStateCopyWithImpl(_$_CreateWalletScreenState _value,
      $Res Function(_$_CreateWalletScreenState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? auraFullInfoWallet = freezed,
  }) {
    return _then(_$_CreateWalletScreenState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateWalletScreenStatus,
      auraFullInfoWallet: freezed == auraFullInfoWallet
          ? _value.auraFullInfoWallet
          : auraFullInfoWallet // ignore: cast_nullable_to_non_nullable
              as AuraFullInfoWallet?,
    ));
  }
}

/// @nodoc

class _$_CreateWalletScreenState implements _CreateWalletScreenState {
  const _$_CreateWalletScreenState(
      {this.status = CreateWalletScreenStatus.loading,
      this.auraFullInfoWallet});

  @override
  @JsonKey()
  final CreateWalletScreenStatus status;
  @override
  final AuraFullInfoWallet? auraFullInfoWallet;

  @override
  String toString() {
    return 'CreateWalletScreenState(status: $status, auraFullInfoWallet: $auraFullInfoWallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateWalletScreenState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.auraFullInfoWallet, auraFullInfoWallet) ||
                other.auraFullInfoWallet == auraFullInfoWallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, auraFullInfoWallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateWalletScreenStateCopyWith<_$_CreateWalletScreenState>
      get copyWith =>
          __$$_CreateWalletScreenStateCopyWithImpl<_$_CreateWalletScreenState>(
              this, _$identity);
}

abstract class _CreateWalletScreenState implements CreateWalletScreenState {
  const factory _CreateWalletScreenState(
          {final CreateWalletScreenStatus status,
          final AuraFullInfoWallet? auraFullInfoWallet}) =
      _$_CreateWalletScreenState;

  @override
  CreateWalletScreenStatus get status;
  @override
  AuraFullInfoWallet? get auraFullInfoWallet;
  @override
  @JsonKey(ignore: true)
  _$$_CreateWalletScreenStateCopyWith<_$_CreateWalletScreenState>
      get copyWith => throw _privateConstructorUsedError;
}
