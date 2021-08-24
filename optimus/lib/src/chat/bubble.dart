import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/chat/message.dart';
import 'package:optimus/src/stack.dart';
import 'package:optimus/src/typography/presets.dart';

/// Chat bubble component offers single configurable bubble. The main use of
/// this widget is in OptimusChat widget but it can be used also stand-alone.
class OptimusChatBubble extends StatelessWidget {
  const OptimusChatBubble({
    Key? key,
    required this.message,
    required this.isUserNameVisible,
    required this.isDateVisible,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.error,
  }) : super(key: key);

  final OptimusMessage message;
  final bool isUserNameVisible;
  final bool isDateVisible;
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget sending;
  final Widget sent;
  final Widget error;

  Widget _buildMessageBubble(OptimusThemeData theme) => Container(
        margin: EdgeInsets.only(
          top: isUserNameVisible ? spacing0 : spacing100,
          left: message.alignment == MessageAlignment.left ? spacing100 : 64,
          right: message.alignment == MessageAlignment.right ? spacing100 : 64,
        ),
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: _buildMessageBackground(theme),
        padding: const EdgeInsets.only(
          left: spacing100,
          right: spacing100,
          top: spacing50,
          bottom: spacing100,
        ),
        child: Text(
          message.message,
          style: preset200s.copyWith(color: _createMessageTextColor(theme)),
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
          Text(formatDate(message.time), style: preset100s),
          separator,
        ],
      ),
    );
  }

  Padding get _userName => Padding(
        padding: _userNamePadding(message.alignment),
        child: Text(message.userName, style: preset100s),
      );

  EdgeInsets _userNamePadding(MessageAlignment alignment) => EdgeInsets.only(
    left: alignment == MessageAlignment.left ? spacing100 : 0,
    right: alignment == MessageAlignment.right ? spacing100 : 0,
  );

  OptimusStackAlignment get _bubbleAlignment =>
      message.alignment == MessageAlignment.left
          ? OptimusStackAlignment.start
          : OptimusStackAlignment.end;

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

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return OptimusStack(
      spacing: OptimusStackSpacing.spacing50,
      crossAxisAlignment: _bubbleAlignment,
      children: [
        if (isDateVisible) _buildDate(theme),
        if (isUserNameVisible) _userName,
        _buildMessageBubble(theme),
      ],
    );
  }
}
