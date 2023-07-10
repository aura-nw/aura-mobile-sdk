// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_wallet_screen_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateWalletScreenEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWalletScreenStartEvent value) start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateWalletScreenStartEvent value)? start,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWalletScreenStartEvent value)? start,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateWalletScreenEventCopyWith<$Res> {
  factory $CreateWalletScreenEventCopyWith(CreateWalletScreenEvent value,
          $Res Function(CreateWalletScreenEvent) then) =
      _$CreateWalletScreenEventCopyWithImpl<$Res, CreateWalletScreenEvent>;
}

/// @nodoc
class _$CreateWalletScreenEventCopyWithImpl<$Res,
        $Val extends CreateWalletScreenEvent>
    implements $CreateWalletScreenEventCopyWith<$Res> {
  _$CreateWalletScreenEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CreateWalletScreenStartEventCopyWith<$Res> {
  factory _$$CreateWalletScreenStartEventCopyWith(
          _$CreateWalletScreenStartEvent value,
          $Res Function(_$CreateWalletScreenStartEvent) then) =
      __$$CreateWalletScreenStartEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateWalletScreenStartEventCopyWithImpl<$Res>
    extends _$CreateWalletScreenEventCopyWithImpl<$Res,
        _$CreateWalletScreenStartEvent>
    implements _$$CreateWalletScreenStartEventCopyWith<$Res> {
  __$$CreateWalletScreenStartEventCopyWithImpl(
      _$CreateWalletScreenStartEvent _value,
      $Res Function(_$CreateWalletScreenStartEvent) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateWalletScreenStartEvent implements CreateWalletScreenStartEvent {
  const _$CreateWalletScreenStartEvent();

  @override
  String toString() {
    return 'CreateWalletScreenEvent.start()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateWalletScreenStartEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() start,
  }) {
    return start();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? start,
  }) {
    return start?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? start,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateWalletScreenStartEvent value) start,
  }) {
    return start(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateWalletScreenStartEvent value)? start,
  }) {
    return start?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateWalletScreenStartEvent value)? start,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(this);
    }
    return orElse();
  }
}

abstract class CreateWalletScreenStartEvent implements CreateWalletScreenEvent {
  const factory CreateWalletScreenStartEvent() = _$CreateWalletScreenStartEvent;
}
