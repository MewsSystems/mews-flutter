import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

/// Chat bubble component offers single configurable bubble. The main use of
/// this widget is in OptimusChat widget but it can be used also stand-alone.
class OptimusChatBubble extends StatelessWidget {
  const OptimusChatBubble({
    super.key,
    required this.message,
    required this.isUserNameVisible,
    required this.isDateVisible,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.error,
  });

  final OptimusMessage message;
  final bool isUserNameVisible;
  final bool isDateVisible;
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget sending;
  final Widget sent;
  final Widget error;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: message.alignment.crossAxisAlignment,
      children: [
        if (isDateVisible) ...[
          SizedBox(height: tokens.spacing200),
          _Date(date: formatDate(message.time)),
          SizedBox(height: tokens.spacing200),
        ],
        SizedBox(height: tokens.spacing100),
        if (isUserNameVisible) ...[
          Padding(
            padding: message.alignment.getHorizontalPadding(tokens),
            child: Text(message.author.username, style: tokens.bodySmallStrong),
          ),
          SizedBox(height: tokens.spacing50),
        ],
        Padding(
          padding: message.alignment.getHorizontalPadding(tokens),
          child: _Bubble(message: message),
        ),
      ],
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    final horizontalLine = Container(
      height: 1,
      color: OptimusTheme.of(context).colors.neutral50,
    );
    final tokens = context.tokens;

    return OptimusStack(
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing100,
      children: [
        Expanded(child: horizontalLine),
        Text(date, style: tokens.bodySmallStrong),
        Expanded(child: horizontalLine),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final OptimusMessage message;

  Color _getBackgroundColor(OptimusThemeData theme) => switch (message.color) {
        MessageColor.neutral => theme.colors.neutral25,
        MessageColor.dark => theme.colors.primary,
        MessageColor.light => theme.colors.primary500t16,
      };

  Color _getTextColor(OptimusThemeData theme) => switch (message.color) {
        MessageColor.neutral => theme.colors.neutral1000,
        MessageColor.light =>
          theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000,
        MessageColor.dark => theme.colors.neutral0,
      };

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final tokens = context.tokens;

    return Container(
      constraints: const BoxConstraints(maxWidth: 480),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(tokens.borderRadius100),
        color: _getBackgroundColor(theme), // TODO(witwash): check with design
      ),
      padding: EdgeInsets.only(
        left: tokens.spacing100,
        right: tokens.spacing100,
        top: tokens.spacing50,
        bottom: tokens.spacing100,
      ),
      child: Text(
        message.message,
        style: tokens.bodyMediumStrong.copyWith(color: _getTextColor(theme)),
      ),
    );
  }
}

extension on MessageAlignment {
  EdgeInsetsGeometry getHorizontalPadding(OptimusTokens tokens) =>
      switch (this) {
        MessageAlignment.left =>
          EdgeInsets.only(left: tokens.spacing100, right: tokens.spacing0),
        MessageAlignment.right =>
          EdgeInsets.only(left: tokens.spacing0, right: tokens.spacing100),
      };

  CrossAxisAlignment get crossAxisAlignment => switch (this) {
        MessageAlignment.left => CrossAxisAlignment.start,
        MessageAlignment.right => CrossAxisAlignment.end,
      };
}
