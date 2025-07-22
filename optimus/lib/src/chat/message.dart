import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

enum MessageAlignment { left, right }

enum MessageColor { user, received, success }

enum MessageState { sending, sent, error }

typedef TryAgainCallback =
    Future<MessageState> Function(OptimusMessage message);

@freezed
class OptimusMessage with _$OptimusMessage {
  const factory OptimusMessage({
    required OptimusMessageAuthor author,
    required String message,
    required MessageAlignment alignment,
    required MessageColor color,
    required DateTime time,
    required MessageState state,
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
