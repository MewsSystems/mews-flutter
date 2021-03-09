// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OptimusThemeDataTearOff {
  const _$OptimusThemeDataTearOff();

  _OptimusThemeData call(
      {required Brightness brightness, required OptimusColors colors}) {
    return _OptimusThemeData(
      brightness: brightness,
      colors: colors,
    );
  }
}

/// @nodoc
const $OptimusThemeData = _$OptimusThemeDataTearOff();

/// @nodoc
mixin _$OptimusThemeData {
  Brightness get brightness => throw _privateConstructorUsedError;
  OptimusColors get colors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OptimusThemeDataCopyWith<OptimusThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusThemeDataCopyWith<$Res> {
  factory $OptimusThemeDataCopyWith(
          OptimusThemeData value, $Res Function(OptimusThemeData) then) =
      _$OptimusThemeDataCopyWithImpl<$Res>;
  $Res call({Brightness brightness, OptimusColors colors});
}

/// @nodoc
class _$OptimusThemeDataCopyWithImpl<$Res>
    implements $OptimusThemeDataCopyWith<$Res> {
  _$OptimusThemeDataCopyWithImpl(this._value, this._then);

  final OptimusThemeData _value;
  // ignore: unused_field
  final $Res Function(OptimusThemeData) _then;

  @override
  $Res call({
    Object? brightness = freezed,
    Object? colors = freezed,
  }) {
    return _then(_value.copyWith(
      brightness:
          brightness == freezed ? _value.brightness : brightness as Brightness,
      colors: colors == freezed ? _value.colors : colors as OptimusColors,
    ));
  }
}

/// @nodoc
abstract class _$OptimusThemeDataCopyWith<$Res>
    implements $OptimusThemeDataCopyWith<$Res> {
  factory _$OptimusThemeDataCopyWith(
          _OptimusThemeData value, $Res Function(_OptimusThemeData) then) =
      __$OptimusThemeDataCopyWithImpl<$Res>;
  @override
  $Res call({Brightness brightness, OptimusColors colors});
}

/// @nodoc
class __$OptimusThemeDataCopyWithImpl<$Res>
    extends _$OptimusThemeDataCopyWithImpl<$Res>
    implements _$OptimusThemeDataCopyWith<$Res> {
  __$OptimusThemeDataCopyWithImpl(
      _OptimusThemeData _value, $Res Function(_OptimusThemeData) _then)
      : super(_value, (v) => _then(v as _OptimusThemeData));

  @override
  _OptimusThemeData get _value => super._value as _OptimusThemeData;

  @override
  $Res call({
    Object? brightness = freezed,
    Object? colors = freezed,
  }) {
    return _then(_OptimusThemeData(
      brightness:
          brightness == freezed ? _value.brightness : brightness as Brightness,
      colors: colors == freezed ? _value.colors : colors as OptimusColors,
    ));
  }
}

/// @nodoc
class _$_OptimusThemeData extends _OptimusThemeData {
  const _$_OptimusThemeData({required this.brightness, required this.colors})
      : super._();

  @override
  final Brightness brightness;
  @override
  final OptimusColors colors;

  @override
  String toString() {
    return 'OptimusThemeData(brightness: $brightness, colors: $colors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OptimusThemeData &&
            (identical(other.brightness, brightness) ||
                const DeepCollectionEquality()
                    .equals(other.brightness, brightness)) &&
            (identical(other.colors, colors) ||
                const DeepCollectionEquality().equals(other.colors, colors)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(brightness) ^
      const DeepCollectionEquality().hash(colors);

  @JsonKey(ignore: true)
  @override
  _$OptimusThemeDataCopyWith<_OptimusThemeData> get copyWith =>
      __$OptimusThemeDataCopyWithImpl<_OptimusThemeData>(this, _$identity);
}

abstract class _OptimusThemeData extends OptimusThemeData {
  const _OptimusThemeData._() : super._();
  const factory _OptimusThemeData(
      {required Brightness brightness,
      required OptimusColors colors}) = _$_OptimusThemeData;

  @override
  Brightness get brightness => throw _privateConstructorUsedError;
  @override
  OptimusColors get colors => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OptimusThemeDataCopyWith<_OptimusThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}
