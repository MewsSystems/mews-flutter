import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

enum MessageOwner { assistant, user }

enum MessageState { basic, typing, success }

enum MessageDeliveryStatus { sending, sent, error }

typedef TryAgainCallback =
    Future<MessageDeliveryStatus> Function(OptimusMessage message);

@freezed
class OptimusMessage with _$OptimusMessage {
  const factory OptimusMessage({
    required OptimusMessageAuthor author,
    required String message,
    required MessageOwner owner,
    @Default(MessageState.basic) MessageState state,
    required DateTime time,
    @Default(MessageDeliveryStatus.sent) MessageDeliveryStatus deliveryStatus,
  }) = _Message;
}

@freezed
class OptimusMessageAuthor with _$OptimusMessageAuthor {
  const factory OptimusMessageAuthor({
    required String id,
    required String username,
    Widget? avatar,
  }) = _OptimusMessageAuthor;
}
