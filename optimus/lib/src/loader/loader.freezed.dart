// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loader.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OptimusCircleLoaderVariant {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() indeterminate,
    required TResult Function(double progress) determinate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? indeterminate,
    TResult? Function(double progress)? determinate,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Indeterminate value)? indeterminate,
    TResult? Function(Determinate value)? determinate,
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
      _$OptimusCircleLoaderVariantCopyWithImpl<$Res,
          OptimusCircleLoaderVariant>;
}

/// @nodoc
class _$OptimusCircleLoaderVariantCopyWithImpl<$Res,
        $Val extends OptimusCircleLoaderVariant>
    implements $OptimusCircleLoaderVariantCopyWith<$Res> {
  _$OptimusCircleLoaderVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IndeterminateImplCopyWith<$Res> {
  factory _$$IndeterminateImplCopyWith(
          _$IndeterminateImpl value, $Res Function(_$IndeterminateImpl) then) =
      __$$IndeterminateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IndeterminateImplCopyWithImpl<$Res>
    extends _$OptimusCircleLoaderVariantCopyWithImpl<$Res, _$IndeterminateImpl>
    implements _$$IndeterminateImplCopyWith<$Res> {
  __$$IndeterminateImplCopyWithImpl(
      _$IndeterminateImpl _value, $Res Function(_$IndeterminateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$IndeterminateImpl implements Indeterminate {
  const _$IndeterminateImpl();

  @override
  String toString() {
    return 'OptimusCircleLoaderVariant.indeterminate()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IndeterminateImpl);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? indeterminate,
    TResult? Function(double progress)? determinate,
  }) {
    return indeterminate?.call();
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Indeterminate value)? indeterminate,
    TResult? Function(Determinate value)? determinate,
  }) {
    return indeterminate?.call(this);
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
  const factory Indeterminate() = _$IndeterminateImpl;
}

/// @nodoc
abstract class _$$DeterminateImplCopyWith<$Res> {
  factory _$$DeterminateImplCopyWith(
          _$DeterminateImpl value, $Res Function(_$DeterminateImpl) then) =
      __$$DeterminateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double progress});
}

/// @nodoc
class __$$DeterminateImplCopyWithImpl<$Res>
    extends _$OptimusCircleLoaderVariantCopyWithImpl<$Res, _$DeterminateImpl>
    implements _$$DeterminateImplCopyWith<$Res> {
  __$$DeterminateImplCopyWithImpl(
      _$DeterminateImpl _value, $Res Function(_$DeterminateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
  }) {
    return _then(_$DeterminateImpl(
      null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DeterminateImpl implements Determinate {
  const _$DeterminateImpl(this.progress);

  @override
  final double progress;

  @override
  String toString() {
    return 'OptimusCircleLoaderVariant.determinate(progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeterminateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeterminateImplCopyWith<_$DeterminateImpl> get copyWith =>
      __$$DeterminateImplCopyWithImpl<_$DeterminateImpl>(this, _$identity);

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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? indeterminate,
    TResult? Function(double progress)? determinate,
  }) {
    return determinate?.call(progress);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Indeterminate value)? indeterminate,
    TResult? Function(Determinate value)? determinate,
  }) {
    return determinate?.call(this);
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
  const factory Determinate(final double progress) = _$DeterminateImpl;

  double get progress;
  @JsonKey(ignore: true)
  _$$DeterminateImplCopyWith<_$DeterminateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
