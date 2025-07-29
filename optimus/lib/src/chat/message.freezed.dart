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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OptimusMessage {
  OptimusMessageAuthor get author => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  MessageOwner get owner => throw _privateConstructorUsedError;
  MessageState get state => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  MessageDeliveryStatus get deliveryStatus =>
      throw _privateConstructorUsedError;

  /// Create a copy of OptimusMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptimusMessageCopyWith<OptimusMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusMessageCopyWith<$Res> {
  factory $OptimusMessageCopyWith(
    OptimusMessage value,
    $Res Function(OptimusMessage) then,
  ) = _$OptimusMessageCopyWithImpl<$Res, OptimusMessage>;
  @useResult
  $Res call({
    OptimusMessageAuthor author,
    String message,
    MessageOwner owner,
    MessageState state,
    DateTime time,
    MessageDeliveryStatus deliveryStatus,
  });

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

  /// Create a copy of OptimusMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? message = null,
    Object? owner = null,
    Object? state = null,
    Object? time = null,
    Object? deliveryStatus = null,
  }) {
    return _then(
      _value.copyWith(
            author:
                null == author
                    ? _value.author
                    : author // ignore: cast_nullable_to_non_nullable
                        as OptimusMessageAuthor,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            owner:
                null == owner
                    ? _value.owner
                    : owner // ignore: cast_nullable_to_non_nullable
                        as MessageOwner,
            state:
                null == state
                    ? _value.state
                    : state // ignore: cast_nullable_to_non_nullable
                        as MessageState,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            deliveryStatus:
                null == deliveryStatus
                    ? _value.deliveryStatus
                    : deliveryStatus // ignore: cast_nullable_to_non_nullable
                        as MessageDeliveryStatus,
          )
          as $Val,
    );
  }

  /// Create a copy of OptimusMessage
  /// with the given fields replaced by the non-null parameter values.
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
    _$MessageImpl value,
    $Res Function(_$MessageImpl) then,
  ) = __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    OptimusMessageAuthor author,
    String message,
    MessageOwner owner,
    MessageState state,
    DateTime time,
    MessageDeliveryStatus deliveryStatus,
  });

  @override
  $OptimusMessageAuthorCopyWith<$Res> get author;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$OptimusMessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
    _$MessageImpl _value,
    $Res Function(_$MessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OptimusMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? message = null,
    Object? owner = null,
    Object? state = null,
    Object? time = null,
    Object? deliveryStatus = null,
  }) {
    return _then(
      _$MessageImpl(
        author:
            null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                    as OptimusMessageAuthor,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        owner:
            null == owner
                ? _value.owner
                : owner // ignore: cast_nullable_to_non_nullable
                    as MessageOwner,
        state:
            null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                    as MessageState,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        deliveryStatus:
            null == deliveryStatus
                ? _value.deliveryStatus
                : deliveryStatus // ignore: cast_nullable_to_non_nullable
                    as MessageDeliveryStatus,
      ),
    );
  }
}

/// @nodoc

class _$MessageImpl implements _Message {
  const _$MessageImpl({
    required this.author,
    required this.message,
    required this.owner,
    this.state = MessageState.basic,
    required this.time,
    this.deliveryStatus = MessageDeliveryStatus.sent,
  });

  @override
  final OptimusMessageAuthor author;
  @override
  final String message;
  @override
  final MessageOwner owner;
  @override
  @JsonKey()
  final MessageState state;
  @override
  final DateTime time;
  @override
  @JsonKey()
  final MessageDeliveryStatus deliveryStatus;

  @override
  String toString() {
    return 'OptimusMessage(author: $author, message: $message, owner: $owner, state: $state, time: $time, deliveryStatus: $deliveryStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    author,
    message,
    owner,
    state,
    time,
    deliveryStatus,
  );

  /// Create a copy of OptimusMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);
}

abstract class _Message implements OptimusMessage {
  const factory _Message({
    required final OptimusMessageAuthor author,
    required final String message,
    required final MessageOwner owner,
    final MessageState state,
    required final DateTime time,
    final MessageDeliveryStatus deliveryStatus,
  }) = _$MessageImpl;

  @override
  OptimusMessageAuthor get author;
  @override
  String get message;
  @override
  MessageOwner get owner;
  @override
  MessageState get state;
  @override
  DateTime get time;
  @override
  MessageDeliveryStatus get deliveryStatus;

  /// Create a copy of OptimusMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OptimusMessageAuthor {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  Widget? get avatar => throw _privateConstructorUsedError;

  /// Create a copy of OptimusMessageAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptimusMessageAuthorCopyWith<OptimusMessageAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimusMessageAuthorCopyWith<$Res> {
  factory $OptimusMessageAuthorCopyWith(
    OptimusMessageAuthor value,
    $Res Function(OptimusMessageAuthor) then,
  ) = _$OptimusMessageAuthorCopyWithImpl<$Res, OptimusMessageAuthor>;
  @useResult
  $Res call({String id, String username, Widget? avatar});
}

/// @nodoc
class _$OptimusMessageAuthorCopyWithImpl<
  $Res,
  $Val extends OptimusMessageAuthor
>
    implements $OptimusMessageAuthorCopyWith<$Res> {
  _$OptimusMessageAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OptimusMessageAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? avatar = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            username:
                null == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as Widget?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OptimusMessageAuthorImplCopyWith<$Res>
    implements $OptimusMessageAuthorCopyWith<$Res> {
  factory _$$OptimusMessageAuthorImplCopyWith(
    _$OptimusMessageAuthorImpl value,
    $Res Function(_$OptimusMessageAuthorImpl) then,
  ) = __$$OptimusMessageAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String username, Widget? avatar});
}

/// @nodoc
class __$$OptimusMessageAuthorImplCopyWithImpl<$Res>
    extends _$OptimusMessageAuthorCopyWithImpl<$Res, _$OptimusMessageAuthorImpl>
    implements _$$OptimusMessageAuthorImplCopyWith<$Res> {
  __$$OptimusMessageAuthorImplCopyWithImpl(
    _$OptimusMessageAuthorImpl _value,
    $Res Function(_$OptimusMessageAuthorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OptimusMessageAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? avatar = freezed,
  }) {
    return _then(
      _$OptimusMessageAuthorImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        username:
            null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as Widget?,
      ),
    );
  }
}

/// @nodoc

class _$OptimusMessageAuthorImpl implements _OptimusMessageAuthor {
  const _$OptimusMessageAuthorImpl({
    required this.id,
    required this.username,
    this.avatar,
  });

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
  bool operator ==(Object other) {
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

  /// Create a copy of OptimusMessageAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OptimusMessageAuthorImplCopyWith<_$OptimusMessageAuthorImpl>
  get copyWith =>
      __$$OptimusMessageAuthorImplCopyWithImpl<_$OptimusMessageAuthorImpl>(
        this,
        _$identity,
      );
}

abstract class _OptimusMessageAuthor implements OptimusMessageAuthor {
  const factory _OptimusMessageAuthor({
    required final String id,
    required final String username,
    final Widget? avatar,
  }) = _$OptimusMessageAuthorImpl;

  @override
  String get id;
  @override
  String get username;
  @override
  Widget? get avatar;

  /// Create a copy of OptimusMessageAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OptimusMessageAuthorImplCopyWith<_$OptimusMessageAuthorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
