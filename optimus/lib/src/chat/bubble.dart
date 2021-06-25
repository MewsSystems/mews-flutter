import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/stack.dart';
import 'package:optimus/src/typography/presets.dart';

part 'bubble.freezed.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.index,
    required this.message,
    required this.showAvatar,
    required this.showStatus,
    required this.showUserName,
    required this.formatTime,
    required this.sending,
    required this.sent,
    required this.notSend,
    required this.tryAgain,
    required this.onTryAgainClicked,
  }) : super(key: key);

  final int index;
  final Message message;
  final MessageStatus status;
  final bool showAvatar;
  final bool showUserName;
  final bool showStatus;
  final Function formatTime;
  final Widget sending;
  final Widget notSend;
  final Widget sent;
  final Widget tryAgain;
  final TrySendAgain onTryAgainClicked;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return IntrinsicHeight(
      child: OptimusStack(
        spacing: OptimusStackSpacing.spacing50,
        crossAxisAlignment: _bubbleAlignment,
        children: [
          if (showUserName) _userName,
          OptimusStack(
            direction: Axis.horizontal,
            mainAxisAlignment: _bubbleAlignment,
            crossAxisAlignment: OptimusStackAlignment.end,
            spacing: OptimusStackSpacing.spacing100,
            children: [
              if (message.type == MessageType.inbound) _avatar,
              _messageBubble(theme),
              if (message.type != MessageType.inbound) _avatar,
            ],
          ),
          if (showStatus) _status(theme),
        ],
      ),
    );
  }

  Widget _messageBubble(OptimusThemeData theme) =>
      Padding(
        padding: EdgeInsets.only(top: showUserName ? spacing0 : spacing100),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: _messageBackground(theme),
          padding: const EdgeInsets.all(spacing100),
          child: DefaultTextStyle.merge(
            style: TextStyle.lerp(
                preset200s, TextStyle(color: _messageTextColor(theme)), 1),
            child: Text(message.message),
          ),
        ),
      );

  Padding get _userName =>
      Padding(
        padding: _statusPadding,
        child: DefaultTextStyle.merge(
          style: preset100s,
          child: Text(message.userName),
        ),
      );

  Padding _status(OptimusThemeData theme) =>
      Padding(
        padding: _statusPadding,
        child: DefaultTextStyle.merge(
          style: TextStyle.lerp(
            preset100s,
            TextStyle(color: theme.colors.neutral1000t64),
            1,
          ),
          child: _statusText(index, message, theme),
        ),
      );

  EdgeInsets get _statusPadding =>
      EdgeInsets.only(
        left: message.type == MessageType.inbound ? 48 : 0,
        right: message.type != MessageType.inbound ? 48 : 0,
      );

  Widget _statusText(int index, Message message, OptimusThemeData theme) {
    late final List<Widget> children;

    switch (status) {
      case MessageStatus.sending:
        children = [
          Text(formatTime(message.time) as String),
          sending,
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                width: 1,
                color: theme.colors.neutral1000t64,
              ),
            ),
          ),
        ];
        break;
      case MessageStatus.sent:
        children = [
          Text(formatTime(message.time) as String),
          if (message.type == MessageType.outbound) sent,
          if (message.type == MessageType.outbound)
            const OptimusIcon(
              iconData: OptimusIcons.done_circle,
              iconSize: OptimusIconSize.small,
            )
        ];
        break;
      case MessageStatus.notSent:
        children = [
          notSend,
          DefaultTextStyle.merge(
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
            child: GestureDetector(
                onTap: () => onTryAgainClicked(index, message),
                child: tryAgain),
          ),
          const OptimusIcon(
            iconData: OptimusIcons.disable,
            iconSize: OptimusIconSize.small,
            colorOption: OptimusColorOption.danger,
          ),
        ];
        break;
    }

    return OptimusStack(
      mainAxisAlignment: _bubbleAlignment,
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing50,
      children: children,
    );
  }

  OptimusStackAlignment get _bubbleAlignment =>
      message.type == MessageType.inbound
          ? OptimusStackAlignment.start
          : OptimusStackAlignment.end;

  Widget get _avatar {
    if (showAvatar) {
      if (message.type == MessageType.outboundOrganisation &&
          message.organisationAvatarUrl?.isNotEmpty == true) {
        return Stack(children: [
          OptimusAvatar(title: message.userName, imageUrl: message.avatarUrl),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(message.organisationAvatarUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ]);
      } else {
        return OptimusAvatar(
            title: message.userName, imageUrl: message.avatarUrl);
      }
    } else {
      return _emptyAvatarSpace;
    }
  }

  Widget get _emptyAvatarSpace => const SizedBox(width: 40);

  BoxDecoration _messageBackground(OptimusThemeData theme) =>
      BoxDecoration(
        borderRadius: const BorderRadius.all(borderRadius100),
        color: _messageBackgroundColor(theme),
      );

  Color _messageBackgroundColor(OptimusThemeData theme) {
    switch (message.type) {
      case MessageType.inbound:
        return theme.colors.neutral25;
      case MessageType.outbound:
        return theme.colors.primary;
      case MessageType.outboundOrganisation:
        return theme.colors.primary500t16;
    }
  }

  Color _messageTextColor(OptimusThemeData theme) {
    switch (message.type) {
      case MessageType.inbound:
      case MessageType.outboundOrganisation:
        return theme.colors.neutral1000;
      case MessageType.outbound:
        return theme.colors.neutral0;
    }
  }
}

enum MessageType {
  /// Incoming messages from the user's (your) perspective.
  /// Available only in single appearance for all scenarios and included parties.
  inbound,

  /// Message sent by the user (you), this from your perspective with multiple
  /// variants including organization and customer side.
  /// Available in various delivery states.
  outbound,

  /// An alternative to a standard user message.
  /// Only used by another organization member
  /// in the same conversation with the customer.
  outboundOrganisation,
}

enum MessageStatus {
  /// The message is currently in the process of being sent.
  sending,

  /// The message has been successfully sent.
  sent,

  /// An error occurred. The message has not been sent.
  notSent,
}

typedef TrySendAgain = Future<MessageStatus> Function(
    int index, Message message);

@freezed
class Message with _$Message {
  const factory Message({
    required String userName,
    required String message,
    required MessageType type,
    required DateTime time,
    required MessageStatus status,
    String? avatarUrl,
    String? organisationAvatarUrl,
  }) = _Message;
}
