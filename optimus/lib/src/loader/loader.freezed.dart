// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'loader.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OptimusCircleLoaderVariantTearOff {
  const _$OptimusCircleLoaderVariantTearOff();

  Indeterminate indeterminate() {
    return const Indeterminate();
  }

  Determinate determinate(double progress) {
    return Determinate(
      progress,
    );
  }
}

/// @nodoc
const $OptimusCircleLoaderVariant = _$OptimusCircleLoaderVariantTearOff();

/// @nodoc
mixin _$OptimusCircleLoaderVariant {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() indeterminate,
    required TResult Function(double progress) determinate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? indeterminate,
    TResult Function(double progress)? determinate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Indeterminate value) indeterminate,
    required TResult Function(Determinate value) determinate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Indeterminate value)? indeterminate,
    TResult Function(Determinate value)? determinate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusCircleLoaderVariantCopyWith<$Res> {
  factory $OptimusCircleLoaderVariantCopyWith(OptimusCircleLoaderVariant value,
          $Res Function(OptimusCircleLoaderVariant) then) =
      _$OptimusCircleLoaderVariantCopyWithImpl<$Res>;
}

/// @nodoc
class _$OptimusCircleLoaderVariantCopyWithImpl<$Res>
    implements $OptimusCircleLoaderVariantCopyWith<$Res> {
  _$OptimusCircleLoaderVariantCopyWithImpl(this._value, this._then);

  final OptimusCircleLoaderVariant _value;
  // ignore: unused_field
  final $Res Function(OptimusCircleLoaderVariant) _then;
}

/// @nodoc
abstract class $IndeterminateCopyWith<$Res> {
  factory $IndeterminateCopyWith(
          Indeterminate value, $Res Function(Indeterminate) then) =
      _$IndeterminateCopyWithImpl<$Res>;
}

/// @nodoc
class _$IndeterminateCopyWithImpl<$Res>
    extends _$OptimusCircleLoaderVariantCopyWithImpl<$Res>
    implements $IndeterminateCopyWith<$Res> {
  _$IndeterminateCopyWithImpl(
      Indeterminate _value, $Res Function(Indeterminate) _then)
      : super(_value, (v) => _then(v as Indeterminate));

  @override
  Indeterminate get _value => super._value as Indeterminate;
}

/// @nodoc

class _$Indeterminate implements Indeterminate {
  const _$Indeterminate();

  @override
  String toString() {
    return 'OptimusCircleLoaderVariant.indeterminate()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Indeterminate);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() indeterminate,
    required TResult Function(double progress) determinate,
  }) {
    return indeterminate();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? indeterminate,
    TResult Function(double progress)? determinate,
    required TResult orElse(),
  }) {
    if (indeterminate != null) {
      return indeterminate();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Indeterminate value) indeterminate,
    required TResult Function(Determinate value) determinate,
  }) {
    return indeterminate(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Indeterminate value)? indeterminate,
    TResult Function(Determinate value)? determinate,
    required TResult orElse(),
  }) {
    if (indeterminate != null) {
      return indeterminate(this);
    }
    return orElse();
  }
}

abstract class Indeterminate implements OptimusCircleLoaderVariant {
  const factory Indeterminate() = _$Indeterminate;
}

/// @nodoc
abstract class $DeterminateCopyWith<$Res> {
  factory $DeterminateCopyWith(
          Determinate value, $Res Function(Determinate) then) =
      _$DeterminateCopyWithImpl<$Res>;
  $Res call({double progress});
}

/// @nodoc
class _$DeterminateCopyWithImpl<$Res>
    extends _$OptimusCircleLoaderVariantCopyWithImpl<$Res>
    implements $DeterminateCopyWith<$Res> {
  _$DeterminateCopyWithImpl(
      Determinate _value, $Res Function(Determinate) _then)
      : super(_value, (v) => _then(v as Determinate));

  @override
  Determinate get _value => super._value as Determinate;

  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(Determinate(
      progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$Determinate implements Determinate {
  const _$Determinate(this.progress);

  @override
  final double progress;

  @override
  String toString() {
    return 'OptimusCircleLoaderVariant.determinate(progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Determinate &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality()
                    .equals(other.progress, progress)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(progress);

  @JsonKey(ignore: true)
  @override
  $DeterminateCopyWith<Determinate> get copyWith =>
      _$DeterminateCopyWithImpl<Determinate>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() indeterminate,
    required TResult Function(double progress) determinate,
  }) {
    return determinate(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? indeterminate,
    TResult Function(double progress)? determinate,
    required TResult orElse(),
  }) {
    if (determinate != null) {
      return determinate(progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Indeterminate value) indeterminate,
    required TResult Function(Determinate value) determinate,
  }) {
    return determinate(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Indeterminate value)? indeterminate,
    TResult Function(Determinate value)? determinate,
    required TResult orElse(),
  }) {
    if (determinate != null) {
      return determinate(this);
    }
    return orElse();
  }
}

abstract class Determinate implements OptimusCircleLoaderVariant {
  const factory Determinate(double progress) = _$Determinate;

  double get progress => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeterminateCopyWith<Determinate> get copyWith =>
      throw _privateConstructorUsedError;
}
