// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OptimusMessageTearOff {
  const _$OptimusMessageTearOff();

  _Message call(
      {required OptimusMessageAuthor author,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state}) {
    return _Message(
      author: author,
      message: message,
      alignment: alignment,
      color: color,
      time: time,
      state: state,
    );
  }
}

/// @nodoc
const $OptimusMessage = _$OptimusMessageTearOff();

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
      _$OptimusMessageCopyWithImpl<$Res>;
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
class _$OptimusMessageCopyWithImpl<$Res>
    implements $OptimusMessageCopyWith<$Res> {
  _$OptimusMessageCopyWithImpl(this._value, this._then);

  final OptimusMessage _value;
  // ignore: unused_field
  final $Res Function(OptimusMessage) _then;

  @override
  $Res call({
    Object? author = freezed,
    Object? message = freezed,
    Object? alignment = freezed,
    Object? color = freezed,
    Object? time = freezed,
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as OptimusMessageAuthor,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      alignment: alignment == freezed
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as MessageAlignment,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as MessageColor,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MessageState,
    ));
  }

  @override
  $OptimusMessageAuthorCopyWith<$Res> get author {
    return $OptimusMessageAuthorCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value));
    });
  }
}

/// @nodoc
abstract class _$MessageCopyWith<$Res>
    implements $OptimusMessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) then) =
      __$MessageCopyWithImpl<$Res>;
  @override
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
class __$MessageCopyWithImpl<$Res> extends _$OptimusMessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(_Message _value, $Res Function(_Message) _then)
      : super(_value, (v) => _then(v as _Message));

  @override
  _Message get _value => super._value as _Message;

  @override
  $Res call({
    Object? author = freezed,
    Object? message = freezed,
    Object? alignment = freezed,
    Object? color = freezed,
    Object? time = freezed,
    Object? state = freezed,
  }) {
    return _then(_Message(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as OptimusMessageAuthor,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      alignment: alignment == freezed
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as MessageAlignment,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as MessageColor,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      state: state == freezed
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MessageState,
    ));
  }
}

/// @nodoc

class _$_Message implements _Message {
  const _$_Message(
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
            other is _Message &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.alignment, alignment) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality().equals(other.state, state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(alignment),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(state));

  @JsonKey(ignore: true)
  @override
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);
}

abstract class _Message implements OptimusMessage {
  const factory _Message(
      {required OptimusMessageAuthor author,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state}) = _$_Message;

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
  _$MessageCopyWith<_Message> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$OptimusMessageAuthorTearOff {
  const _$OptimusMessageAuthorTearOff();

  _OptimusMessageAuthor call(
      {required String id, required String username, Widget? avatar}) {
    return _OptimusMessageAuthor(
      id: id,
      username: username,
      avatar: avatar,
    );
  }
}

/// @nodoc
const $OptimusMessageAuthor = _$OptimusMessageAuthorTearOff();

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
      _$OptimusMessageAuthorCopyWithImpl<$Res>;
  $Res call({String id, String username, Widget? avatar});
}

/// @nodoc
class _$OptimusMessageAuthorCopyWithImpl<$Res>
    implements $OptimusMessageAuthorCopyWith<$Res> {
  _$OptimusMessageAuthorCopyWithImpl(this._value, this._then);

  final OptimusMessageAuthor _value;
  // ignore: unused_field
  final $Res Function(OptimusMessageAuthor) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ));
  }
}

/// @nodoc
abstract class _$OptimusMessageAuthorCopyWith<$Res>
    implements $OptimusMessageAuthorCopyWith<$Res> {
  factory _$OptimusMessageAuthorCopyWith(_OptimusMessageAuthor value,
          $Res Function(_OptimusMessageAuthor) then) =
      __$OptimusMessageAuthorCopyWithImpl<$Res>;
  @override
  $Res call({String id, String username, Widget? avatar});
}

/// @nodoc
class __$OptimusMessageAuthorCopyWithImpl<$Res>
    extends _$OptimusMessageAuthorCopyWithImpl<$Res>
    implements _$OptimusMessageAuthorCopyWith<$Res> {
  __$OptimusMessageAuthorCopyWithImpl(
      _OptimusMessageAuthor _value, $Res Function(_OptimusMessageAuthor) _then)
      : super(_value, (v) => _then(v as _OptimusMessageAuthor));

  @override
  _OptimusMessageAuthor get _value => super._value as _OptimusMessageAuthor;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_OptimusMessageAuthor(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ));
  }
}

/// @nodoc

class _$_OptimusMessageAuthor implements _OptimusMessageAuthor {
  const _$_OptimusMessageAuthor(
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
            other is _OptimusMessageAuthor &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.avatar, avatar));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(avatar));

  @JsonKey(ignore: true)
  @override
  _$OptimusMessageAuthorCopyWith<_OptimusMessageAuthor> get copyWith =>
      __$OptimusMessageAuthorCopyWithImpl<_OptimusMessageAuthor>(
          this, _$identity);
}

abstract class _OptimusMessageAuthor implements OptimusMessageAuthor {
  const factory _OptimusMessageAuthor(
      {required String id,
      required String username,
      Widget? avatar}) = _$_OptimusMessageAuthor;

  @override
  String get id;
  @override
  String get username;
  @override
  Widget? get avatar;
  @override
  @JsonKey(ignore: true)
  _$OptimusMessageAuthorCopyWith<_OptimusMessageAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}
