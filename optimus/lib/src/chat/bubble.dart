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
        margin: message.alignment
            .messageBubbleMargins(isUserNameVisible: isUserNameVisible),
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
        color: theme.colors.neutral50,
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
        padding: message.alignment.edgeInsetsGeometry,
        child: Text(message.author.username, style: preset100s),
      );

  OptimusStackAlignment get _bubbleAlignment {
    switch (message.alignment) {
      case MessageAlignment.left:
        return OptimusStackAlignment.start;
      case MessageAlignment.right:
        return OptimusStackAlignment.end;
    }
  }

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

extension on MessageAlignment {
  EdgeInsetsGeometry get edgeInsetsGeometry {
    switch (this) {
      case MessageAlignment.left:
        return const EdgeInsets.only(left: spacing100, right: 0);
      case MessageAlignment.right:
        return const EdgeInsets.only(left: 0, right: spacing100);
    }
  }

  EdgeInsets messageBubbleMargins({required bool isUserNameVisible}) {
    switch (this) {
      case MessageAlignment.left:
        return EdgeInsets.only(
          top: isUserNameVisible ? spacing0 : spacing100,
          left: spacing100,
          right: 64,
        );
      case MessageAlignment.right:
        return EdgeInsets.only(
          top: isUserNameVisible ? spacing0 : spacing100,
          left: 64,
          right: spacing100,
        );
    }
  }
}
