import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/stack.dart';
import 'package:optimus/src/typography/presets.dart';

part 'bubble.freezed.dart';

/// Chat bubble component offers single configurable bubble. The main use of
/// this widget is in OptimusChat widget but it can be used also stand-alone.

class OptimusChatBubble extends StatelessWidget {
  const OptimusChatBubble({
    Key? key,
    required this.index,
    required this.message,
    required this.showAvatar,
    required this.showStatus,
    required this.showUserName,
    required this.showDate,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.notSend,
    required this.tryAgain,
    required this.onTryAgainClicked,
  }) : super(key: key);

  final int index;
  final OptimusMessage message;
  final bool showAvatar;
  final bool showStatus;
  final bool showUserName;
  final bool showDate;
  final Function formatTime;
  final Function formatDate;
  final Widget sending;
  final Widget notSend;
  final Widget sent;
  final Widget tryAgain;
  final TrySendAgain onTryAgainClicked;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return OptimusStack(
      spacing: OptimusStackSpacing.spacing50,
      crossAxisAlignment: _bubbleAlignment,
      children: [
        if (showDate) _buildDate(theme),
        if (showUserName) _userName,
        OptimusStack(
          direction: Axis.horizontal,
          mainAxisAlignment: _bubbleAlignment,
          crossAxisAlignment: OptimusStackAlignment.end,
          children: [
            if (message.alignment == MessageAlignment.left) _avatar,
            _buildMessageBubble(theme),
            if (message.alignment == MessageAlignment.right) _avatar,
          ],
        ),
        if (showStatus) _buildStatus(theme),
      ],
    );
  }

  Widget _buildMessageBubble(OptimusThemeData theme) => Flexible(
        child: Container(
          margin: EdgeInsets.only(
            top: showUserName ? spacing0 : spacing100,
            left: message.alignment == MessageAlignment.left ? spacing100 : 64,
            right:
                message.alignment == MessageAlignment.right ? spacing100 : 64,
          ),
          constraints: const BoxConstraints(maxWidth: 480),
          decoration: _buildMessageBackground(theme),
          padding: const EdgeInsets.only(
            left: spacing100,
            right: spacing100,
            top: spacing50,
            bottom: spacing100,
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle.lerp(preset200s,
                TextStyle(color: _createMessageTextColor(theme)), 1),
            child: Text(message.message),
          ),
        ),
      );

  Widget _buildDate(OptimusThemeData theme) {
    final separator = Expanded(
      child: Container(
        height: 1,
        color: theme.isDark
            ? theme.colors.neutral0t32
            : theme.colors.neutral1000t32,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: spacing200),
      child: OptimusStack(
        direction: Axis.horizontal,
        spacing: OptimusStackSpacing.spacing100,
        children: [
          separator,
          Text(formatDate(message.time) as String, style: preset100s),
          separator,
        ],
      ),
    );
  }

  Padding get _userName => Padding(
        padding: _statusPadding,
        child: DefaultTextStyle.merge(
          style: preset100s,
          child: Text(message.userName),
        ),
      );

  Padding _buildStatus(OptimusThemeData theme) => Padding(
        padding: _statusPadding,
        child: _buildStatusText(index, message, theme),
      );

  EdgeInsets get _statusPadding => EdgeInsets.only(
        left: message.alignment == MessageAlignment.left ? 48 : 0,
        right: message.alignment != MessageAlignment.left ? 48 : 0,
      );

  Widget _buildStatusTextStyle(OptimusThemeData theme, Widget child) =>
      DefaultTextStyle.merge(
        style: TextStyle(
          color: theme.isDark
              ? theme.colors.neutral0t64
              : theme.colors.neutral1000t64,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        child: child,
      );

  Widget _buildStatusText(
    int index,
    OptimusMessage message,
    OptimusThemeData theme,
  ) {
    late final List<Widget> children;
    final color =
        theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;

    switch (message.status) {
      case MessageStatus.sending:
        children = [
          _buildStatusTextStyle(
            theme,
            Text(formatTime(message.time) as String),
          ),
          _buildStatusTextStyle(theme, sending),
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                width: 1.2,
                color: color,
              ),
            ),
          ),
        ];
        break;
      case MessageStatus.sent:
        children = [
          _buildStatusTextStyle(
            theme,
            Text(formatTime(message.time) as String),
          ),
          if (message.alignment == MessageAlignment.right)
            _buildStatusTextStyle(theme, sent),
          if (message.alignment == MessageAlignment.right)
            const Opacity(
              opacity: 0.6,
              child: OptimusIcon(
                iconData: OptimusIcons.done_circle,
                iconSize: OptimusIconSize.small,
              ),
            )
        ];
        break;
      case MessageStatus.notSent:
        children = [
          _buildStatusTextStyle(theme, notSend),
          DefaultTextStyle.merge(
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
            child: GestureDetector(
              onTap: () => onTryAgainClicked(index, message),
              child: _buildStatusTextStyle(theme, tryAgain),
            ),
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
      message.alignment == MessageAlignment.left
          ? OptimusStackAlignment.start
          : OptimusStackAlignment.end;

  Widget get _avatar => showAvatar ? message.avatar : _emptyAvatarSpace;

  Widget get _emptyAvatarSpace => const SizedBox(width: 40);

  BoxDecoration _buildMessageBackground(OptimusThemeData theme) =>
      BoxDecoration(
        borderRadius: const BorderRadius.all(borderRadius100),
        color: _createMessageBackgroundColor(theme),
      );

  Color _createMessageBackgroundColor(OptimusThemeData theme) {
    switch (message.color) {
      case MessageColor.neutral:
        return theme.colors.neutral25;
      case MessageColor.dark:
        return theme.colors.primary;
      case MessageColor.light:
        return theme.colors.primary500t16;
    }
  }

  Color _createMessageTextColor(OptimusThemeData theme) {
    switch (message.color) {
      case MessageColor.neutral:
        return theme.colors.neutral1000;
      case MessageColor.light:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;
      case MessageColor.dark:
        return theme.colors.neutral0;
    }
  }
}

enum MessageAlignment {
  left,
  right,
}

enum MessageColor {
  neutral,
  light,
  dark,
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
    int index, OptimusMessage message);

@freezed
class OptimusMessage with _$OptimusMessage {
  const factory OptimusMessage({
    required String userName,
    required String message,
    required MessageAlignment alignment,
    required MessageColor color,
    required DateTime time,
    required MessageStatus status,
    required Widget avatar,
  }) = _Message;
}
