import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/feedback/feedback_variant.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus_icons/optimus_icons.dart';

class FeedbackIcon extends StatelessWidget {
  const FeedbackIcon({super.key, required this.variant, this.icon});

  final OptimusFeedbackVariant variant;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Icon(
      icon ?? variant.icon,
      color: variant.getIconColor(tokens),
      size: tokens.sizing300,
    );
  }
}

class FeedbackDismissButton extends StatelessWidget {
  const FeedbackDismissButton({super.key, required this.onDismiss});

  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return GestureDetector(
      onTap: onDismiss,
      child: Icon(
        OptimusIcons.cross_close,
        size: tokens.sizing200,
        color: tokens.textStaticPrimary,
      ),
    );
  }
}

class FeedbackTitle extends StatelessWidget {
  const FeedbackTitle({super.key, required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle.merge(
      child: title,
      style: tokens.bodyMediumStrong.copyWith(color: tokens.textStaticPrimary),
    );
  }
}

class FeedbackDescription extends StatelessWidget {
  const FeedbackDescription({super.key, required this.description});

  final Widget description;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle.merge(
      child: description,
      maxLines: _maxLinesDescription,
      overflow: overflowStyle,
      style: tokens.bodyMedium.copyWith(color: tokens.textStaticPrimary),
    );
  }
}

class FeedbackLink extends StatelessWidget {
  const FeedbackLink({super.key, required this.text, this.semanticLinkUri});

  final Widget text;
  final Uri? semanticLinkUri;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Semantics(
      link: true,
      linkUrl: semanticLinkUri,
      child: DefaultTextStyle.merge(
        child: text,
        maxLines: _maxLinesLink,
        overflow: overflowStyle,
        style: tokens.bodyMediumStrong.copyWith(
          color: tokens.textStaticSecondary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

const int _maxLinesDescription = 5;
const int _maxLinesLink = 1;
const TextOverflow overflowStyle = TextOverflow.ellipsis;
