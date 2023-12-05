// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OptimusMessage {
  OptimusMessageAuthor get author => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  MessageAlignment get alignment => throw _privateConstructorUsedError;
  MessageColor get color => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  MessageState get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OptimusMessageCopyWith<OptimusMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusMessageCopyWith<$Res> {
  factory $OptimusMessageCopyWith(
          OptimusMessage value, $Res Function(OptimusMessage) then) =
      _$OptimusMessageCopyWithImpl<$Res, OptimusMessage>;
  @useResult
  $Res call(
      {OptimusMessageAuthor author,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state});

  $OptimusMessageAuthorCopyWith<$Res> get author;
}

/// @nodoc
class _$OptimusMessageCopyWithImpl<$Res, $Val extends OptimusMessage>
    implements $OptimusMessageCopyWith<$Res> {
  _$OptimusMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? message = null,
    Object? alignment = null,
    Object? color = null,
    Object? time = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as OptimusMessageAuthor,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      alignment: null == alignment
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as MessageAlignment,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as MessageColor,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MessageState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OptimusMessageAuthorCopyWith<$Res> get author {
    return $OptimusMessageAuthorCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res>
    implements $OptimusMessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OptimusMessageAuthor author,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state});

  @override
  $OptimusMessageAuthorCopyWith<$Res> get author;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$OptimusMessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? message = null,
    Object? alignment = null,
    Object? color = null,
    Object? time = null,
    Object? state = null,
  }) {
    return _then(_$MessageImpl(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as OptimusMessageAuthor,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      alignment: null == alignment
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as MessageAlignment,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as MessageColor,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MessageState,
    ));
  }
}

/// @nodoc

class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {required this.author,
      required this.message,
      required this.alignment,
      required this.color,
      required this.time,
      required this.state});

  @override
  final OptimusMessageAuthor author;
  @override
  final String message;
  @override
  final MessageAlignment alignment;
  @override
  final MessageColor color;
  @override
  final DateTime time;
  @override
  final MessageState state;

  @override
  String toString() {
    return 'OptimusMessage(author: $author, message: $message, alignment: $alignment, color: $color, time: $time, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, author, message, alignment, color, time, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);
}

abstract class _Message implements OptimusMessage {
  const factory _Message(
      {required final OptimusMessageAuthor author,
      required final String message,
      required final MessageAlignment alignment,
      required final MessageColor color,
      required final DateTime time,
      required final MessageState state}) = _$MessageImpl;

  @override
  OptimusMessageAuthor get author;
  @override
  String get message;
  @override
  MessageAlignment get alignment;
  @override
  MessageColor get color;
  @override
  DateTime get time;
  @override
  MessageState get state;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OptimusMessageAuthor {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  Widget? get avatar => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OptimusMessageAuthorCopyWith<OptimusMessageAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusMessageAuthorCopyWith<$Res> {
  factory $OptimusMessageAuthorCopyWith(OptimusMessageAuthor value,
          $Res Function(OptimusMessageAuthor) then) =
      _$OptimusMessageAuthorCopyWithImpl<$Res, OptimusMessageAuthor>;
  @useResult
  $Res call({String id, String username, Widget? avatar});
}

/// @nodoc
class _$OptimusMessageAuthorCopyWithImpl<$Res,
        $Val extends OptimusMessageAuthor>
    implements $OptimusMessageAuthorCopyWith<$Res> {
  _$OptimusMessageAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptimusMessageAuthorImplCopyWith<$Res>
    implements $OptimusMessageAuthorCopyWith<$Res> {
  factory _$$OptimusMessageAuthorImplCopyWith(_$OptimusMessageAuthorImpl value,
          $Res Function(_$OptimusMessageAuthorImpl) then) =
      __$$OptimusMessageAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String username, Widget? avatar});
}

/// @nodoc
class __$$OptimusMessageAuthorImplCopyWithImpl<$Res>
    extends _$OptimusMessageAuthorCopyWithImpl<$Res, _$OptimusMessageAuthorImpl>
    implements _$$OptimusMessageAuthorImplCopyWith<$Res> {
  __$$OptimusMessageAuthorImplCopyWithImpl(_$OptimusMessageAuthorImpl _value,
      $Res Function(_$OptimusMessageAuthorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? avatar = freezed,
  }) {
    return _then(_$OptimusMessageAuthorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ));
  }
}

/// @nodoc

class _$OptimusMessageAuthorImpl implements _OptimusMessageAuthor {
  const _$OptimusMessageAuthorImpl(
      {required this.id, required this.username, this.avatar});

  @override
  final String id;
  @override
  final String username;
  @override
  final Widget? avatar;

  @override
  String toString() {
    return 'OptimusMessageAuthor(id: $id, username: $username, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptimusMessageAuthorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, username, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptimusMessageAuthorImplCopyWith<_$OptimusMessageAuthorImpl>
      get copyWith =>
          __$$OptimusMessageAuthorImplCopyWithImpl<_$OptimusMessageAuthorImpl>(
              this, _$identity);
}

abstract class _OptimusMessageAuthor implements OptimusMessageAuthor {
  const factory _OptimusMessageAuthor(
      {required final String id,
      required final String username,
      final Widget? avatar}) = _$OptimusMessageAuthorImpl;

  @override
  String get id;
  @override
  String get username;
  @override
  Widget? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$OptimusMessageAuthorImplCopyWith<_$OptimusMessageAuthorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
