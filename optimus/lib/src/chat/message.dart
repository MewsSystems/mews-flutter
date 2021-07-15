import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

enum MessageAlignment {
  left,
  right,
}

enum MessageColor {
  neutral,
  light,
  dark,
}

@freezed
class MessageState with _$MessageState {
  const factory MessageState.sending({
    required String text,
  }) = MessageStateSending;

  const factory MessageState.sent({
    required String text,
  }) = MessageStateSent;

  const factory MessageState.error({
    required String text,
    required VoidCallback onTryAgain,
  }) = MessageStateError;
}

typedef TryAgainCallback = Future<MessageState> Function(
    OptimusMessage message);

@freezed
class OptimusMessage with _$OptimusMessage {
  const factory OptimusMessage({
    required String userName,
    required String message,
    required MessageAlignment alignment,
    required MessageColor color,
    required DateTime time,
    required MessageState state,
    required Widget avatar,
  }) = _Message;
}
