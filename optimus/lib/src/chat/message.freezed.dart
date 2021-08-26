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
      {required OptimusMessageSender sender,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state,
      required Widget? avatar}) {
    return _Message(
      sender: sender,
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
  OptimusMessageSender get sender => throw _privateConstructorUsedError;
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
      {OptimusMessageSender sender,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state,
      Widget? avatar});

  $OptimusMessageSenderCopyWith<$Res> get sender;
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
    Object? sender = freezed,
    Object? message = freezed,
    Object? alignment = freezed,
    Object? color = freezed,
    Object? time = freezed,
    Object? state = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as OptimusMessageSender,
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
  $OptimusMessageSenderCopyWith<$Res> get sender {
    return $OptimusMessageSenderCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value));
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
      {OptimusMessageSender sender,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state,
      Widget? avatar});

  @override
  $OptimusMessageSenderCopyWith<$Res> get sender;
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
    Object? sender = freezed,
    Object? message = freezed,
    Object? alignment = freezed,
    Object? color = freezed,
    Object? time = freezed,
    Object? state = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_Message(
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as OptimusMessageSender,
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
      {required this.sender,
      required this.message,
      required this.alignment,
      required this.color,
      required this.time,
      required this.state,
      required this.avatar});

  @override
  final OptimusMessageSender sender;
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
    return 'OptimusMessage(sender: $sender, message: $message, alignment: $alignment, color: $color, time: $time, state: $state, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Message &&
            (identical(other.sender, sender) ||
                const DeepCollectionEquality().equals(other.sender, sender)) &&
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
      const DeepCollectionEquality().hash(sender) ^
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
      {required OptimusMessageSender sender,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state,
      required Widget? avatar}) = _$_Message;

  @override
  OptimusMessageSender get sender => throw _privateConstructorUsedError;
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
class _$OptimusMessageSenderTearOff {
  const _$OptimusMessageSenderTearOff();

  _OptimusMessageSender call({required String id, required String userName}) {
    return _OptimusMessageSender(
      id: id,
      userName: userName,
    );
  }
}

/// @nodoc
const $OptimusMessageSender = _$OptimusMessageSenderTearOff();

/// @nodoc
mixin _$OptimusMessageSender {
  String get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OptimusMessageSenderCopyWith<OptimusMessageSender> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusMessageSenderCopyWith<$Res> {
  factory $OptimusMessageSenderCopyWith(OptimusMessageSender value,
          $Res Function(OptimusMessageSender) then) =
      _$OptimusMessageSenderCopyWithImpl<$Res>;
  $Res call({String id, String userName});
}

/// @nodoc
class _$OptimusMessageSenderCopyWithImpl<$Res>
    implements $OptimusMessageSenderCopyWith<$Res> {
  _$OptimusMessageSenderCopyWithImpl(this._value, this._then);

  final OptimusMessageSender _value;
  // ignore: unused_field
  final $Res Function(OptimusMessageSender) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$OptimusMessageSenderCopyWith<$Res>
    implements $OptimusMessageSenderCopyWith<$Res> {
  factory _$OptimusMessageSenderCopyWith(_OptimusMessageSender value,
          $Res Function(_OptimusMessageSender) then) =
      __$OptimusMessageSenderCopyWithImpl<$Res>;
  @override
  $Res call({String id, String userName});
}

/// @nodoc
class __$OptimusMessageSenderCopyWithImpl<$Res>
    extends _$OptimusMessageSenderCopyWithImpl<$Res>
    implements _$OptimusMessageSenderCopyWith<$Res> {
  __$OptimusMessageSenderCopyWithImpl(
      _OptimusMessageSender _value, $Res Function(_OptimusMessageSender) _then)
      : super(_value, (v) => _then(v as _OptimusMessageSender));

  @override
  _OptimusMessageSender get _value => super._value as _OptimusMessageSender;

  @override
  $Res call({
    Object? id = freezed,
    Object? userName = freezed,
  }) {
    return _then(_OptimusMessageSender(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_OptimusMessageSender implements _OptimusMessageSender {
  const _$_OptimusMessageSender({required this.id, required this.userName});

  @override
  final String id;
  @override
  final String userName;

  @override
  String toString() {
    return 'OptimusMessageSender(id: $id, userName: $userName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OptimusMessageSender &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userName);

  @JsonKey(ignore: true)
  @override
  _$OptimusMessageSenderCopyWith<_OptimusMessageSender> get copyWith =>
      __$OptimusMessageSenderCopyWithImpl<_OptimusMessageSender>(
          this, _$identity);
}

abstract class _OptimusMessageSender implements OptimusMessageSender {
  const factory _OptimusMessageSender(
      {required String id, required String userName}) = _$_OptimusMessageSender;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OptimusMessageSenderCopyWith<_OptimusMessageSender> get copyWith =>
      throw _privateConstructorUsedError;
}
