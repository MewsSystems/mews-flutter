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

enum MessageState {
  sending,
  sent,
  error,
}

typedef TryAgainCallback = Future<MessageState> Function(
    OptimusMessage message);

@freezed
class OptimusMessage with _$OptimusMessage {
  const factory OptimusMessage({
    required MessageAuthor author,
    required String message,
    required MessageAlignment alignment,
    required MessageColor color,
    required DateTime time,
    required MessageState state,
    required Widget? avatar,
  }) = _Message;
}

@freezed
class MessageAuthor with _$MessageAuthor {
  const factory MessageAuthor({
    required String id,
    required String username,
  }) = _MessageAuthor;
}
