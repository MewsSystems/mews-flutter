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
  const FeedbackTitle({
    super.key,
    required this.title,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  });

  final Widget title;
  final int? maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle.merge(
      child: title,
      maxLines: maxLines,
      overflow: maxLines != null ? overflow : null,
      style: tokens.bodyMediumStrong.copyWith(color: tokens.textStaticPrimary),
    );
  }
}

class FeedbackDescription extends StatelessWidget {
  const FeedbackDescription({
    super.key,
    required this.description,
    this.maxLines = 5,
    this.overflow = TextOverflow.ellipsis,
  });

  final Widget description;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle.merge(
      child: description,
      maxLines: maxLines,
      overflow: overflow,
      style: tokens.bodyMedium.copyWith(color: tokens.textStaticPrimary),
    );
  }
}

class FeedbackLink extends StatelessWidget {
  const FeedbackLink({
    super.key,
    required this.text,
    required this.onPressed,
    this.semanticLinkUri,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  });

  final Widget text;
  final VoidCallback onPressed;
  final Uri? semanticLinkUri;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Semantics(
      link: true,
      linkUrl: semanticLinkUri,
      child: GestureDetector(
        onTap: onPressed,
        child: DefaultTextStyle.merge(
          child: text,
          maxLines: maxLines,
          overflow: overflow,
          style: tokens.bodyMediumStrong.copyWith(
            color: tokens.textStaticSecondary,
            decoration: .underline,
          ),
        ),
      ),
    );
  }
}
