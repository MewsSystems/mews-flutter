// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OptimusThemeData {
  Brightness get brightness => throw _privateConstructorUsedError;
  OptimusColors get colors => throw _privateConstructorUsedError;
  OptimusTokens get tokens => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OptimusThemeDataCopyWith<OptimusThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusThemeDataCopyWith<$Res> {
  factory $OptimusThemeDataCopyWith(
          OptimusThemeData value, $Res Function(OptimusThemeData) then) =
      _$OptimusThemeDataCopyWithImpl<$Res, OptimusThemeData>;
  @useResult
  $Res call(
      {Brightness brightness, OptimusColors colors, OptimusTokens tokens});
}

/// @nodoc
class _$OptimusThemeDataCopyWithImpl<$Res, $Val extends OptimusThemeData>
    implements $OptimusThemeDataCopyWith<$Res> {
  _$OptimusThemeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brightness = null,
    Object? colors = null,
    Object? tokens = null,
  }) {
    return _then(_value.copyWith(
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as OptimusColors,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as OptimusTokens,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptimusThemeDataImplCopyWith<$Res>
    implements $OptimusThemeDataCopyWith<$Res> {
  factory _$$OptimusThemeDataImplCopyWith(_$OptimusThemeDataImpl value,
          $Res Function(_$OptimusThemeDataImpl) then) =
      __$$OptimusThemeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Brightness brightness, OptimusColors colors, OptimusTokens tokens});
}

/// @nodoc
class __$$OptimusThemeDataImplCopyWithImpl<$Res>
    extends _$OptimusThemeDataCopyWithImpl<$Res, _$OptimusThemeDataImpl>
    implements _$$OptimusThemeDataImplCopyWith<$Res> {
  __$$OptimusThemeDataImplCopyWithImpl(_$OptimusThemeDataImpl _value,
      $Res Function(_$OptimusThemeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brightness = null,
    Object? colors = null,
    Object? tokens = null,
  }) {
    return _then(_$OptimusThemeDataImpl(
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as OptimusColors,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as OptimusTokens,
    ));
  }
}

/// @nodoc

class _$OptimusThemeDataImpl extends _OptimusThemeData {
  const _$OptimusThemeDataImpl(
      {required this.brightness, required this.colors, required this.tokens})
      : super._();

  @override
  final Brightness brightness;
  @override
  final OptimusColors colors;
  @override
  final OptimusTokens tokens;

  @override
  String toString() {
    return 'OptimusThemeData(brightness: $brightness, colors: $colors, tokens: $tokens)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptimusThemeDataImpl &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brightness, colors, tokens);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptimusThemeDataImplCopyWith<_$OptimusThemeDataImpl> get copyWith =>
      __$$OptimusThemeDataImplCopyWithImpl<_$OptimusThemeDataImpl>(
          this, _$identity);
}

abstract class _OptimusThemeData extends OptimusThemeData {
  const factory _OptimusThemeData(
      {required final Brightness brightness,
      required final OptimusColors colors,
      required final OptimusTokens tokens}) = _$OptimusThemeDataImpl;
  const _OptimusThemeData._() : super._();

  @override
  Brightness get brightness;
  @override
  OptimusColors get colors;
  @override
  OptimusTokens get tokens;
  @override
  @JsonKey(ignore: true)
  _$$OptimusThemeDataImplCopyWith<_$OptimusThemeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
