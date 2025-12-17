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
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.error,
    this.maxWidth = 480,
  });

  final OptimusMessage message;
  final bool isUserNameVisible;
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget sending;
  final Widget sent;
  final Widget error;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: message.owner.crossAxisAlignment,
      children: [
        SizedBox(height: tokens.spacing100).excludeSemantics(),
        if (isUserNameVisible) ...[
          Padding(
            padding: message.owner.getHorizontalPadding(tokens),
            child: Text(
              message.author.username,
              style: tokens.bodySmallStrong.copyWith(
                color: tokens.textStaticTertiary,
              ),
            ),
          ),
          SizedBox(height: tokens.spacing50).excludeSemantics(),
        ],
        Padding(
          padding: message.owner.getHorizontalPadding(tokens),
          child: _Bubble(message: message, maxWidth: maxWidth),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message, required this.maxWidth});

  final OptimusMessage message;
  final double maxWidth;

  Color _getBackgroundColor(OptimusTokens tokens) => message.state == .success
      ? tokens.backgroundAlertSuccessSecondary
      : switch (message.owner) {
          .assistant => tokens.backgroundStaticFlat,
          .user => tokens.backgroundAlertInfoSecondary,
        };

  Color _getTextColor(OptimusTokens tokens) => message.state == .success
      ? tokens.textAlertSuccess
      : tokens.textStaticPrimary;

  Color _getBorderColor(OptimusTokens tokens) => message.state == .success
      ? tokens.borderAlertSuccess
      : switch (message.owner) {
          .assistant => tokens.borderStaticTertiary,
          .user => Colors.transparent,
        };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Semantics(
      liveRegion: true,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          borderRadius: .only(
            topLeft: message.owner == .assistant
                ? tokens.borderRadius0
                : context.bubbleRadius,

            topRight: message.owner == .user
                ? tokens.borderRadius0
                : context.bubbleRadius,
            bottomRight: context.bubbleRadius,
            bottomLeft: context.bubbleRadius,
          ),
          color: _getBackgroundColor(tokens),
          border: .all(
            color: _getBorderColor(tokens),
            width: tokens.borderWidth100,
          ),
        ),
        padding: .all(tokens.spacing100),
        child: message.state == .typing
            ? const _TypingBubble()
            : Text(
                message.message,
                style: tokens.bodyMediumStrong.copyWith(
                  color: _getTextColor(tokens),
                ),
              ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      width: tokens.spacing400,
      height: tokens.spacing300,
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '.',
              style: tokens.bodyLarge.copyWith(
                color: tokens.paletteBrandIndigo300,
              ),
            ),
            TextSpan(
              text: '.',
              style: tokens.bodyLarge.copyWith(
                color: tokens.paletteBrandIndigo200,
              ),
            ),
            TextSpan(
              text: '.',
              style: tokens.bodyLarge.copyWith(
                color: tokens.paletteBrandIndigo100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on MessageOwner {
  EdgeInsetsGeometry getHorizontalPadding(OptimusTokens tokens) =>
      switch (this) {
        .assistant => EdgeInsets.only(
          left: tokens.spacing100,
          right: tokens.spacing100,
        ),
        .user => EdgeInsets.only(
          left: tokens.spacing0,
          right: tokens.spacing100,
        ),
      };

  CrossAxisAlignment get crossAxisAlignment => switch (this) {
    .assistant => .start,
    .user => .end,
  };
}

extension on BuildContext {
  Radius get bubbleRadius => tokens.borderRadius200;
}
