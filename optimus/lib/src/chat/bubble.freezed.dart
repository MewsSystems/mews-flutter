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
class _$MessageTearOff {
  const _$MessageTearOff();

  _Message call(
      {required String userName,
      required String message,
      required MessageType type,
      required DateTime time,
      required MessageStatus status,
      String? avatarUrl,
      String? organisationAvatarUrl}) {
    return _Message(
      userName: userName,
      message: message,
      type: type,
      time: time,
      status: status,
      avatarUrl: avatarUrl,
      organisationAvatarUrl: organisationAvatarUrl,
    );
  }
}

/// @nodoc
const $Message = _$MessageTearOff();

/// @nodoc
mixin _$Message {
  String get userName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  MessageStatus get status => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get organisationAvatarUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call(
      {String userName,
      String message,
      MessageType type,
      DateTime time,
      MessageStatus status,
      String? avatarUrl,
      String? organisationAvatarUrl});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? time = freezed,
    Object? status = freezed,
    Object? avatarUrl = freezed,
    Object? organisationAvatarUrl = freezed,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      organisationAvatarUrl: organisationAvatarUrl == freezed
          ? _value.organisationAvatarUrl
          : organisationAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) then) =
      __$MessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userName,
      String message,
      MessageType type,
      DateTime time,
      MessageStatus status,
      String? avatarUrl,
      String? organisationAvatarUrl});
}

/// @nodoc
class __$MessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(_Message _value, $Res Function(_Message) _then)
      : super(_value, (v) => _then(v as _Message));

  @override
  _Message get _value => super._value as _Message;

  @override
  $Res call({
    Object? userName = freezed,
    Object? message = freezed,
    Object? type = freezed,
    Object? time = freezed,
    Object? status = freezed,
    Object? avatarUrl = freezed,
    Object? organisationAvatarUrl = freezed,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      organisationAvatarUrl: organisationAvatarUrl == freezed
          ? _value.organisationAvatarUrl
          : organisationAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Message implements _Message {
  const _$_Message(
      {required this.userName,
      required this.message,
      required this.type,
      required this.time,
      required this.status,
      this.avatarUrl,
      this.organisationAvatarUrl});

  @override
  final String userName;
  @override
  final String message;
  @override
  final MessageType type;
  @override
  final DateTime time;
  @override
  final MessageStatus status;
  @override
  final String? avatarUrl;
  @override
  final String? organisationAvatarUrl;

  @override
  String toString() {
    return 'Message(userName: $userName, message: $message, type: $type, time: $time, status: $status, avatarUrl: $avatarUrl, organisationAvatarUrl: $organisationAvatarUrl)';
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
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.organisationAvatarUrl, organisationAvatarUrl) ||
                const DeepCollectionEquality().equals(
                    other.organisationAvatarUrl, organisationAvatarUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userName) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(organisationAvatarUrl);

  @JsonKey(ignore: true)
  @override
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);
}

abstract class _Message implements Message {
  const factory _Message(
      {required String userName,
      required String message,
      required MessageType type,
      required DateTime time,
      required MessageStatus status,
      String? avatarUrl,
      String? organisationAvatarUrl}) = _$_Message;

  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  MessageType get type => throw _privateConstructorUsedError;
  @override
  DateTime get time => throw _privateConstructorUsedError;
  @override
  MessageStatus get status => throw _privateConstructorUsedError;
  @override
  String? get avatarUrl => throw _privateConstructorUsedError;
  @override
  String? get organisationAvatarUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MessageCopyWith<_Message> get copyWith =>
      throw _privateConstructorUsedError;
}
