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
    required this.isAvatarVisible,
    required this.isAvatarEnabled,
    required this.isStatusVisible,
    required this.isUserNameVisible,
    required this.isDateVisible,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.error,
  }) : super(key: key);

  final OptimusMessage message;
  final bool isAvatarVisible;
  final bool isAvatarEnabled;
  final bool isStatusVisible;
  final bool isUserNameVisible;
  final bool isDateVisible;
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget sending;
  final Widget sent;
  final Widget error;

  Widget _buildMessageBubble(OptimusThemeData theme) => Flexible(
        child: Container(
          margin: EdgeInsets.only(
            top: isUserNameVisible ? spacing0 : spacing100,
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
          child: Text(
            message.message,
            style: preset200s.copyWith(color: _createMessageTextColor(theme)),
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
          Text(formatDate(message.time), style: preset100s),
          separator,
        ],
      ),
    );
  }

  Padding get _userName => Padding(
        padding: _statusPadding,
        child: Text(message.userName, style: preset100s),
      );

  Padding _buildStatus(OptimusThemeData theme) => Padding(
        padding: _statusPadding,
        child: _buildStatusText(message, theme),
      );

  EdgeInsets get _statusPadding => EdgeInsets.only(
        left: message.alignment == MessageAlignment.left
            ? isAvatarEnabled
                ? 48
                : spacing100
            : 0,
        right: message.alignment != MessageAlignment.left
            ? isAvatarEnabled
                ? 48
                : spacing100
            : 0,
      );

  Widget _buildStatusTextStyle(OptimusThemeData theme, Widget child) =>
      DefaultTextStyle.merge(
        style: baseTextStyle.copyWith(
          color: theme.isDark
              ? theme.colors.neutral0t64
              : theme.colors.neutral1000t64,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        child: child,
      );

  Widget _buildStatusText(OptimusMessage message, OptimusThemeData theme) {
    late final List<Widget> children;
    final color =
        theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;

    switch (message.state) {
      case MessageState.sending:
        children = [
          _buildStatusTextStyle(
            theme,
            Text(formatTime(message.time)),
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
      case MessageState.sent:
        children = [
          _buildStatusTextStyle(
            theme,
            Text(formatTime(message.time)),
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
      case MessageState.error:
        children = [
          _buildStatusTextStyle(theme, error),
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

  Widget get _avatar => SizedBox(
        width: 40,
        child: isAvatarVisible ? message.avatar : null,
      );

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
        OptimusStack(
          direction: Axis.horizontal,
          mainAxisAlignment: _bubbleAlignment,
          crossAxisAlignment: OptimusStackAlignment.end,
          children: [
            if (message.alignment == MessageAlignment.left && isAvatarEnabled)
              _avatar,
            _buildMessageBubble(theme),
            if (message.alignment == MessageAlignment.right && isAvatarEnabled)
              _avatar,
          ],
        ),
        if (isStatusVisible) _buildStatus(theme),
      ],
    );
  }
}
