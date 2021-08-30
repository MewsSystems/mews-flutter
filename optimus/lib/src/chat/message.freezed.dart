// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

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
      {required MessageAuthor author,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state,
      required Widget? avatar}) {
    return _Message(
      author: author,
      message: message,
      alignment: alignment,
      color: color,
      time: time,
      state: state,
      avatar: avatar,
    );
  }
}

/// @nodoc
const $OptimusMessage = _$OptimusMessageTearOff();

/// @nodoc
mixin _$OptimusMessage {
  MessageAuthor get author => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  MessageAlignment get alignment => throw _privateConstructorUsedError;
  MessageColor get color => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  MessageState get state => throw _privateConstructorUsedError;
  Widget? get avatar => throw _privateConstructorUsedError;

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
      {MessageAuthor author,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state,
      Widget? avatar});

  $MessageAuthorCopyWith<$Res> get author;
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
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as MessageAuthor,
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
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ));
  }

  @override
  $MessageAuthorCopyWith<$Res> get author {
    return $MessageAuthorCopyWith<$Res>(_value.author, (value) {
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
      {MessageAuthor author,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state,
      Widget? avatar});

  @override
  $MessageAuthorCopyWith<$Res> get author;
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
    Object? avatar = freezed,
  }) {
    return _then(_Message(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as MessageAuthor,
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
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as Widget?,
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
      required this.state,
      required this.avatar});

  @override
  final MessageAuthor author;
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
  final Widget? avatar;

  @override
  String toString() {
    return 'OptimusMessage(author: $author, message: $message, alignment: $alignment, color: $color, time: $time, state: $state, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Message &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.alignment, alignment) ||
                const DeepCollectionEquality()
                    .equals(other.alignment, alignment)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(alignment) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(avatar);

  @JsonKey(ignore: true)
  @override
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);
}

abstract class _Message implements OptimusMessage {
  const factory _Message(
      {required MessageAuthor author,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state,
      required Widget? avatar}) = _$_Message;

  @override
  MessageAuthor get author => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  MessageAlignment get alignment => throw _privateConstructorUsedError;
  @override
  MessageColor get color => throw _privateConstructorUsedError;
  @override
  DateTime get time => throw _privateConstructorUsedError;
  @override
  MessageState get state => throw _privateConstructorUsedError;
  @override
  Widget? get avatar => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MessageCopyWith<_Message> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$MessageAuthorTearOff {
  const _$MessageAuthorTearOff();

  _MessageAuthor call({required String id, required String username}) {
    return _MessageAuthor(
      id: id,
      username: username,
    );
  }
}

/// @nodoc
const $MessageAuthor = _$MessageAuthorTearOff();

/// @nodoc
mixin _$MessageAuthor {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageAuthorCopyWith<MessageAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageAuthorCopyWith<$Res> {
  factory $MessageAuthorCopyWith(
          MessageAuthor value, $Res Function(MessageAuthor) then) =
      _$MessageAuthorCopyWithImpl<$Res>;
  $Res call({String id, String username});
}

/// @nodoc
class _$MessageAuthorCopyWithImpl<$Res>
    implements $MessageAuthorCopyWith<$Res> {
  _$MessageAuthorCopyWithImpl(this._value, this._then);

  final MessageAuthor _value;
  // ignore: unused_field
  final $Res Function(MessageAuthor) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$MessageAuthorCopyWith<$Res>
    implements $MessageAuthorCopyWith<$Res> {
  factory _$MessageAuthorCopyWith(
          _MessageAuthor value, $Res Function(_MessageAuthor) then) =
      __$MessageAuthorCopyWithImpl<$Res>;
  @override
  $Res call({String id, String username});
}

/// @nodoc
class __$MessageAuthorCopyWithImpl<$Res>
    extends _$MessageAuthorCopyWithImpl<$Res>
    implements _$MessageAuthorCopyWith<$Res> {
  __$MessageAuthorCopyWithImpl(
      _MessageAuthor _value, $Res Function(_MessageAuthor) _then)
      : super(_value, (v) => _then(v as _MessageAuthor));

  @override
  _MessageAuthor get _value => super._value as _MessageAuthor;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
  }) {
    return _then(_MessageAuthor(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MessageAuthor implements _MessageAuthor {
  const _$_MessageAuthor({required this.id, required this.username});

  @override
  final String id;
  @override
  final String username;

  @override
  String toString() {
    return 'MessageAuthor(id: $id, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MessageAuthor &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username);

  @JsonKey(ignore: true)
  @override
  _$MessageAuthorCopyWith<_MessageAuthor> get copyWith =>
      __$MessageAuthorCopyWithImpl<_MessageAuthor>(this, _$identity);
}

abstract class _MessageAuthor implements MessageAuthor {
  const factory _MessageAuthor({required String id, required String username}) =
      _$_MessageAuthor;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get username => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MessageAuthorCopyWith<_MessageAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}
