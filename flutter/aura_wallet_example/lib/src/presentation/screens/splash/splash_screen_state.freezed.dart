// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SplashScreenState {
  SplashScreenStatus get status => throw _privateConstructorUsedError;
  AuraWallet? get auraWallet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SplashScreenStateCopyWith<SplashScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplashScreenStateCopyWith<$Res> {
  factory $SplashScreenStateCopyWith(
          SplashScreenState value, $Res Function(SplashScreenState) then) =
      _$SplashScreenStateCopyWithImpl<$Res, SplashScreenState>;
  @useResult
  $Res call({SplashScreenStatus status, AuraWallet? auraWallet});
}

/// @nodoc
class _$SplashScreenStateCopyWithImpl<$Res, $Val extends SplashScreenState>
    implements $SplashScreenStateCopyWith<$Res> {
  _$SplashScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? auraWallet = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplashScreenStatus,
      auraWallet: freezed == auraWallet
          ? _value.auraWallet
          : auraWallet // ignore: cast_nullable_to_non_nullable
              as AuraWallet?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SplashScreenStateCopyWith<$Res>
    implements $SplashScreenStateCopyWith<$Res> {
  factory _$$_SplashScreenStateCopyWith(_$_SplashScreenState value,
          $Res Function(_$_SplashScreenState) then) =
      __$$_SplashScreenStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SplashScreenStatus status, AuraWallet? auraWallet});
}

/// @nodoc
class __$$_SplashScreenStateCopyWithImpl<$Res>
    extends _$SplashScreenStateCopyWithImpl<$Res, _$_SplashScreenState>
    implements _$$_SplashScreenStateCopyWith<$Res> {
  __$$_SplashScreenStateCopyWithImpl(
      _$_SplashScreenState _value, $Res Function(_$_SplashScreenState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? auraWallet = freezed,
  }) {
    return _then(_$_SplashScreenState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplashScreenStatus,
      auraWallet: freezed == auraWallet
          ? _value.auraWallet
          : auraWallet // ignore: cast_nullable_to_non_nullable
              as AuraWallet?,
    ));
  }
}

/// @nodoc

class _$_SplashScreenState implements _SplashScreenState {
  const _$_SplashScreenState(
      {this.status = SplashScreenStatus.starting, this.auraWallet});

  @override
  @JsonKey()
  final SplashScreenStatus status;
  @override
  final AuraWallet? auraWallet;

  @override
  String toString() {
    return 'SplashScreenState(status: $status, auraWallet: $auraWallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SplashScreenState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.auraWallet, auraWallet) ||
                other.auraWallet == auraWallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, auraWallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SplashScreenStateCopyWith<_$_SplashScreenState> get copyWith =>
      __$$_SplashScreenStateCopyWithImpl<_$_SplashScreenState>(
          this, _$identity);
}

abstract class _SplashScreenState implements SplashScreenState {
  const factory _SplashScreenState(
      {final SplashScreenStatus status,
      final AuraWallet? auraWallet}) = _$_SplashScreenState;

  @override
  SplashScreenStatus get status;
  @override
  AuraWallet? get auraWallet;
  @override
  @JsonKey(ignore: true)
  _$$_SplashScreenStateCopyWith<_$_SplashScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}
