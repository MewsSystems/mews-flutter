import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/semantics.dart';

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
          SizedBox(height: tokens.spacing200).excludeSemantics(),
          OptimusDivider(
            child: OptimusCaption(child: Text(formatDate(message.time))),
          ),
          SizedBox(height: tokens.spacing200).excludeSemantics(),
        ],
        SizedBox(height: tokens.spacing100).excludeSemantics(),
        if (isUserNameVisible) ...[
          Padding(
            padding: message.alignment.getHorizontalPadding(tokens),
            child: Text(message.author.username, style: tokens.bodySmallStrong),
          ),
          SizedBox(height: tokens.spacing50).excludeSemantics(),
        ],
        Padding(
          padding: message.alignment.getHorizontalPadding(tokens),
          child: _Bubble(message: message),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final OptimusMessage message;

  Color _getBackgroundColor(OptimusTokens tokens) => switch (message.color) {
    MessageColor.received => tokens.backgroundStaticFlat,
    MessageColor.user => tokens.backgroundAlertInfoSecondary,
    MessageColor.success => tokens.backgroundAlertSuccessSecondary,
  };

  Color _getTextColor(OptimusTokens tokens) => switch (message.color) {
    MessageColor.user || MessageColor.received => tokens.textStaticPrimary,
    MessageColor.success => tokens.textAlertSuccess,
  };

  Color _getBorderColor(OptimusTokens tokens) => switch (message.color) {
    MessageColor.user => Colors.transparent,
    MessageColor.received => tokens.borderStaticTertiary,
    MessageColor.success => tokens.borderAlertSuccess,
  };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Semantics(
      liveRegion: true,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:
                message.alignment == MessageAlignment.left
                    ? tokens.borderRadius0
                    : context.bubbleRadius,

            topRight:
                message.alignment == MessageAlignment.right
                    ? tokens.borderRadius0
                    : context.bubbleRadius,
            bottomRight: context.bubbleRadius,
            bottomLeft: context.bubbleRadius,
          ),
          color: _getBackgroundColor(tokens),
          border: Border.all(
            color: _getBorderColor(tokens),
            width: tokens.borderWidth100,
          ),
        ),
        padding: EdgeInsets.only(
          left: tokens.spacing100,
          right: tokens.spacing100,
          top: tokens.spacing50,
          bottom: tokens.spacing100,
        ),
        child: Text(
          message.message,
          style: tokens.bodyMediumStrong.copyWith(color: _getTextColor(tokens)),
        ),
      ),
    );
  }
}

extension on MessageAlignment {
  EdgeInsetsGeometry getHorizontalPadding(OptimusTokens tokens) =>
      switch (this) {
        MessageAlignment.left => EdgeInsets.only(
          left: tokens.spacing100,
          right: tokens.spacing0,
        ),
        MessageAlignment.right => EdgeInsets.only(
          left: tokens.spacing0,
          right: tokens.spacing100,
        ),
      };

  CrossAxisAlignment get crossAxisAlignment => switch (this) {
    MessageAlignment.left => CrossAxisAlignment.start,
    MessageAlignment.right => CrossAxisAlignment.end,
  };
}

extension on BuildContext {
  Radius get bubbleRadius => tokens.borderRadius200;
}
