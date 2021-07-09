// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bubble.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MessageStateTearOff {
  const _$MessageStateTearOff();

  MessageStateSending sending() {
    return const MessageStateSending();
  }

  MessageStateSent sent() {
    return const MessageStateSent();
  }

  MessageStateError error({required void Function() onTryAgain}) {
    return MessageStateError(
      onTryAgain: onTryAgain,
    );
  }
}

/// @nodoc
const $MessageState = _$MessageStateTearOff();

/// @nodoc
mixin _$MessageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(void Function() onTryAgain) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sending,
    TResult Function()? sent,
    TResult Function(void Function() onTryAgain)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageStateSending value) sending,
    required TResult Function(MessageStateSent value) sent,
    required TResult Function(MessageStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageStateSending value)? sending,
    TResult Function(MessageStateSent value)? sent,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageStateCopyWith<$Res> {
  factory $MessageStateCopyWith(
          MessageState value, $Res Function(MessageState) then) =
      _$MessageStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MessageStateCopyWithImpl<$Res> implements $MessageStateCopyWith<$Res> {
  _$MessageStateCopyWithImpl(this._value, this._then);

  final MessageState _value;
  // ignore: unused_field
  final $Res Function(MessageState) _then;
}

/// @nodoc
abstract class $MessageStateSendingCopyWith<$Res> {
  factory $MessageStateSendingCopyWith(
          MessageStateSending value, $Res Function(MessageStateSending) then) =
      _$MessageStateSendingCopyWithImpl<$Res>;
}

/// @nodoc
class _$MessageStateSendingCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res>
    implements $MessageStateSendingCopyWith<$Res> {
  _$MessageStateSendingCopyWithImpl(
      MessageStateSending _value, $Res Function(MessageStateSending) _then)
      : super(_value, (v) => _then(v as MessageStateSending));

  @override
  MessageStateSending get _value => super._value as MessageStateSending;
}

/// @nodoc

class _$MessageStateSending implements MessageStateSending {
  const _$MessageStateSending();

  @override
  String toString() {
    return 'MessageState.sending()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MessageStateSending);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(void Function() onTryAgain) error,
  }) {
    return sending();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sending,
    TResult Function()? sent,
    TResult Function(void Function() onTryAgain)? error,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageStateSending value) sending,
    required TResult Function(MessageStateSent value) sent,
    required TResult Function(MessageStateError value) error,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageStateSending value)? sending,
    TResult Function(MessageStateSent value)? sent,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class MessageStateSending implements MessageState {
  const factory MessageStateSending() = _$MessageStateSending;
}

/// @nodoc
abstract class $MessageStateSentCopyWith<$Res> {
  factory $MessageStateSentCopyWith(
          MessageStateSent value, $Res Function(MessageStateSent) then) =
      _$MessageStateSentCopyWithImpl<$Res>;
}

/// @nodoc
class _$MessageStateSentCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res>
    implements $MessageStateSentCopyWith<$Res> {
  _$MessageStateSentCopyWithImpl(
      MessageStateSent _value, $Res Function(MessageStateSent) _then)
      : super(_value, (v) => _then(v as MessageStateSent));

  @override
  MessageStateSent get _value => super._value as MessageStateSent;
}

/// @nodoc

class _$MessageStateSent implements MessageStateSent {
  const _$MessageStateSent();

  @override
  String toString() {
    return 'MessageState.sent()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MessageStateSent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(void Function() onTryAgain) error,
  }) {
    return sent();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sending,
    TResult Function()? sent,
    TResult Function(void Function() onTryAgain)? error,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageStateSending value) sending,
    required TResult Function(MessageStateSent value) sent,
    required TResult Function(MessageStateError value) error,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageStateSending value)? sending,
    TResult Function(MessageStateSent value)? sent,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }
}

abstract class MessageStateSent implements MessageState {
  const factory MessageStateSent() = _$MessageStateSent;
}

/// @nodoc
abstract class $MessageStateErrorCopyWith<$Res> {
  factory $MessageStateErrorCopyWith(
          MessageStateError value, $Res Function(MessageStateError) then) =
      _$MessageStateErrorCopyWithImpl<$Res>;
  $Res call({void Function() onTryAgain});
}

/// @nodoc
class _$MessageStateErrorCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res>
    implements $MessageStateErrorCopyWith<$Res> {
  _$MessageStateErrorCopyWithImpl(
      MessageStateError _value, $Res Function(MessageStateError) _then)
      : super(_value, (v) => _then(v as MessageStateError));

  @override
  MessageStateError get _value => super._value as MessageStateError;

  @override
  $Res call({
    Object? onTryAgain = freezed,
  }) {
    return _then(MessageStateError(
      onTryAgain: onTryAgain == freezed
          ? _value.onTryAgain
          : onTryAgain // ignore: cast_nullable_to_non_nullable
              as void Function(),
    ));
  }
}

/// @nodoc

class _$MessageStateError implements MessageStateError {
  const _$MessageStateError({required this.onTryAgain});

  @override
  final void Function() onTryAgain;

  @override
  String toString() {
    return 'MessageState.error(onTryAgain: $onTryAgain)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MessageStateError &&
            (identical(other.onTryAgain, onTryAgain) ||
                const DeepCollectionEquality()
                    .equals(other.onTryAgain, onTryAgain)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(onTryAgain);

  @JsonKey(ignore: true)
  @override
  $MessageStateErrorCopyWith<MessageStateError> get copyWith =>
      _$MessageStateErrorCopyWithImpl<MessageStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sending,
    required TResult Function() sent,
    required TResult Function(void Function() onTryAgain) error,
  }) {
    return error(onTryAgain);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sending,
    TResult Function()? sent,
    TResult Function(void Function() onTryAgain)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(onTryAgain);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageStateSending value) sending,
    required TResult Function(MessageStateSent value) sent,
    required TResult Function(MessageStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageStateSending value)? sending,
    TResult Function(MessageStateSent value)? sent,
    TResult Function(MessageStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MessageStateError implements MessageState {
  const factory MessageStateError({required void Function() onTryAgain}) =
      _$MessageStateError;

  void Function() get onTryAgain => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageStateErrorCopyWith<MessageStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$OptimusMessageTearOff {
  const _$OptimusMessageTearOff();

  _Message call(
      {required String userName,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state,
      required Widget avatar}) {
    return _Message(
      userName: userName,
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
  String get userName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  MessageAlignment get alignment => throw _privateConstructorUsedError;
  MessageColor get color => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  MessageState get state => throw _privateConstructorUsedError;
  Widget get avatar => throw _privateConstructorUsedError;

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
      {String userName,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state,
      Widget avatar});

  $MessageStateCopyWith<$Res> get state;
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
    Object? userName = freezed,
    Object? message = freezed,
    Object? alignment = freezed,
    Object? color = freezed,
    Object? time = freezed,
    Object? state = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
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
              as Widget,
    ));
  }

  @override
  $MessageStateCopyWith<$Res> get state {
    return $MessageStateCopyWith<$Res>(_value.state, (value) {
      return _then(_value.copyWith(state: value));
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
      {String userName,
      String message,
      MessageAlignment alignment,
      MessageColor color,
      DateTime time,
      MessageState state,
      Widget avatar});

  @override
  $MessageStateCopyWith<$Res> get state;
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
    Object? userName = freezed,
    Object? message = freezed,
    Object? alignment = freezed,
    Object? color = freezed,
    Object? time = freezed,
    Object? state = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_Message(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
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
              as Widget,
    ));
  }
}

/// @nodoc

class _$_Message implements _Message {
  const _$_Message(
      {required this.userName,
      required this.message,
      required this.alignment,
      required this.color,
      required this.time,
      required this.state,
      required this.avatar});

  @override
  final String userName;
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
  final Widget avatar;

  @override
  String toString() {
    return 'OptimusMessage(userName: $userName, message: $message, alignment: $alignment, color: $color, time: $time, state: $state, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Message &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
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
      const DeepCollectionEquality().hash(userName) ^
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
      {required String userName,
      required String message,
      required MessageAlignment alignment,
      required MessageColor color,
      required DateTime time,
      required MessageState state,
      required Widget avatar}) = _$_Message;

  @override
  String get userName => throw _privateConstructorUsedError;
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
  Widget get avatar => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MessageCopyWith<_Message> get copyWith =>
      throw _privateConstructorUsedError;
}
