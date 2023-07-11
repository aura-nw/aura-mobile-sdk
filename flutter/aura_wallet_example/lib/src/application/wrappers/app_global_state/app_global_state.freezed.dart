// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_global_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppGlobalState {
  AppGlobalStatus get status => throw _privateConstructorUsedError;
  AuraWallet? get auraWallet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppGlobalStateCopyWith<AppGlobalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppGlobalStateCopyWith<$Res> {
  factory $AppGlobalStateCopyWith(
          AppGlobalState value, $Res Function(AppGlobalState) then) =
      _$AppGlobalStateCopyWithImpl<$Res, AppGlobalState>;
  @useResult
  $Res call({AppGlobalStatus status, AuraWallet? auraWallet});
}

/// @nodoc
class _$AppGlobalStateCopyWithImpl<$Res, $Val extends AppGlobalState>
    implements $AppGlobalStateCopyWith<$Res> {
  _$AppGlobalStateCopyWithImpl(this._value, this._then);

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
              as AppGlobalStatus,
      auraWallet: freezed == auraWallet
          ? _value.auraWallet
          : auraWallet // ignore: cast_nullable_to_non_nullable
              as AuraWallet?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppGlobalStateCopyWith<$Res>
    implements $AppGlobalStateCopyWith<$Res> {
  factory _$$_AppGlobalStateCopyWith(
          _$_AppGlobalState value, $Res Function(_$_AppGlobalState) then) =
      __$$_AppGlobalStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppGlobalStatus status, AuraWallet? auraWallet});
}

/// @nodoc
class __$$_AppGlobalStateCopyWithImpl<$Res>
    extends _$AppGlobalStateCopyWithImpl<$Res, _$_AppGlobalState>
    implements _$$_AppGlobalStateCopyWith<$Res> {
  __$$_AppGlobalStateCopyWithImpl(
      _$_AppGlobalState _value, $Res Function(_$_AppGlobalState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? auraWallet = freezed,
  }) {
    return _then(_$_AppGlobalState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppGlobalStatus,
      auraWallet: freezed == auraWallet
          ? _value.auraWallet
          : auraWallet // ignore: cast_nullable_to_non_nullable
              as AuraWallet?,
    ));
  }
}

/// @nodoc

class _$_AppGlobalState implements _AppGlobalState {
  const _$_AppGlobalState(
      {this.status = AppGlobalStatus.unauthorized, this.auraWallet});

  @override
  @JsonKey()
  final AppGlobalStatus status;
  @override
  final AuraWallet? auraWallet;

  @override
  String toString() {
    return 'AppGlobalState(status: $status, auraWallet: $auraWallet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppGlobalState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.auraWallet, auraWallet) ||
                other.auraWallet == auraWallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, auraWallet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppGlobalStateCopyWith<_$_AppGlobalState> get copyWith =>
      __$$_AppGlobalStateCopyWithImpl<_$_AppGlobalState>(this, _$identity);
}

abstract class _AppGlobalState implements AppGlobalState {
  const factory _AppGlobalState(
      {final AppGlobalStatus status,
      final AuraWallet? auraWallet}) = _$_AppGlobalState;

  @override
  AppGlobalStatus get status;
  @override
  AuraWallet? get auraWallet;
  @override
  @JsonKey(ignore: true)
  _$$_AppGlobalStateCopyWith<_$_AppGlobalState> get copyWith =>
      throw _privateConstructorUsedError;
}
