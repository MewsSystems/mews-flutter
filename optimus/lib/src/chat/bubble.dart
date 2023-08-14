import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

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
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: message.alignment.crossAxisAlignment,
        children: [
          if (isDateVisible) ...[
            const SizedBox(height: spacing200),
            _Date(date: formatDate(message.time)),
            const SizedBox(height: spacing200),
          ],
          const SizedBox(height: spacing100),
          if (isUserNameVisible) ...[
            Padding(
              padding: message.alignment.horizontalPadding,
              child: Text(message.author.username, style: preset100s),
            ),
            const SizedBox(height: spacing50),
          ],
          Padding(
            padding: message.alignment.horizontalPadding,
            child: _Bubble(message: message),
          ),
        ],
      );
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

    return OptimusStack(
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing100,
      children: [
        Expanded(child: horizontalLine),
        Text(date, style: preset100s),
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

    return Container(
      constraints: const BoxConstraints(maxWidth: 480),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(borderRadius100),
        color: _getBackgroundColor(theme),
      ),
      padding: const EdgeInsets.only(
        left: spacing100,
        right: spacing100,
        top: spacing50,
        bottom: spacing100,
      ),
      child: Text(
        message.message,
        style: preset200s.copyWith(color: _getTextColor(theme)),
      ),
    );
  }
}

extension on MessageAlignment {
  EdgeInsetsGeometry get horizontalPadding => switch (this) {
        MessageAlignment.left =>
          const EdgeInsets.only(left: spacing100, right: 0),
        MessageAlignment.right =>
          const EdgeInsets.only(left: 0, right: spacing100),
      };

  CrossAxisAlignment get crossAxisAlignment => switch (this) {
        MessageAlignment.left => CrossAxisAlignment.start,
        MessageAlignment.right => CrossAxisAlignment.end,
      };
}
