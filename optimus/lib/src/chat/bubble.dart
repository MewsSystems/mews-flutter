import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/stack.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.userName,
    required this.message,
    required this.type,
    required this.time,
    required this.status,
    required this.showAvatar,
    required this.showStatus,
    required this.showUserName,
    required this.formatTime,
    this.avatarUrl,
  }) : super(key: key);

  final String userName;
  final String message;
  final MessageType type;
  final DateTime time;
  final MessageStatus status;
  final bool showAvatar;
  final bool showUserName;
  final bool showStatus;
  final String? avatarUrl;
  final Function formatTime;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return IntrinsicHeight(
      child: OptimusStack(
        spacing: OptimusStackSpacing.spacing50,
        crossAxisAlignment: _bubbleAlignment,
        children: [
          if (showUserName) OptimusLabel(child: Text(userName)),
          OptimusStack(
            direction: Axis.horizontal,
            mainAxisAlignment: _bubbleAlignment,
            crossAxisAlignment: OptimusStackAlignment.end,
            spacing: OptimusStackSpacing.spacing100,
            children: [
              if (type == MessageType.inbound)
                _buildAvatar
              else
                _emptyAvatar,
              Container(
                constraints: const BoxConstraints(maxWidth: 480),
                decoration: _messageBackground(theme),
                padding: const EdgeInsets.all(spacing100),
                child: Text(
                  message,
                  style: TextStyle(color: _messageTextColor(theme)),
                ),
              ),
              if (type != MessageType.inbound)
                _buildAvatar
              else
                _emptyAvatar,
            ],
          ),
          OptimusStack(
            mainAxisAlignment: _bubbleAlignment,
            direction: Axis.horizontal,
            children: [
              OptimusLabel(child: Text(_statusText)),
              OptimusIcon(iconData: _statusIcon),
            ],
          ),
        ],
      ),
    );
  }

  IconData get _statusIcon {
    switch (status) {
      case MessageStatus.sending:
        return OptimusIcons.done_circle;
      case MessageStatus.sent:
        return OptimusIcons.done_circle;
      case MessageStatus.notSent:
        return OptimusIcons.delete;
    }
  }

  String get _statusText => formatTime(time) as String;

  OptimusStackAlignment get _bubbleAlignment => type == MessageType.inbound
      ? OptimusStackAlignment.start
      : OptimusStackAlignment.end;

  Widget get _buildAvatar => showAvatar
      ? OptimusAvatar(title: userName, imageUrl: avatarUrl)
      : _emptyAvatar;

  Widget get _emptyAvatar => const SizedBox(width: spacing200);

  BoxDecoration _messageBackground(OptimusThemeData theme) => BoxDecoration(
        borderRadius: const BorderRadius.all(borderRadius100),
        color: _messageBackgroundColor(theme),
      );

  Color _messageBackgroundColor(OptimusThemeData theme) {
    switch (type) {
      case MessageType.inbound:
        return theme.colors.neutral25;
      case MessageType.outbound:
        return theme.colors.primary;
      case MessageType.outboundOrganisation:
        return theme.colors.primary500t16;
    }
  }

  Color _messageTextColor(OptimusThemeData theme) {
    switch (type) {
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
