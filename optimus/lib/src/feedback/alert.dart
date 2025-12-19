import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/semantics.dart';
import 'package:optimus/src/common/text_scaling.dart';
import 'package:optimus/src/feedback/common.dart';

/// Alert is used for showing a brief and concise message that
/// communicates immediate feedback with optional action included. Alerts
/// are noticeable but not intrusive to the use and can be temporary.
class OptimusAlert extends StatelessWidget {
  const OptimusAlert({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.action,
    this.onDismiss,
    this.isDismissible = false,
    this.onPressed,
    this.variant = OptimusFeedbackVariant.info,
    this.maxWidth = 360,
    this.titleMaxLines,
    this.descriptionMaxLines = 5,
    this.linkMaxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  }) : assert(
         title != null || description != null,
         'At least one of title or description must be provided.',
       );

  /// The title of the alert.
  final Widget? title;

  /// The main content or description which should be as brief and straight
  /// to the point.
  final Widget? description;

  /// The icon that will be displayed on the left side of the alert.
  final IconData? icon;

  /// The dismissible callback that will be executed after a click on the close
  /// button.
  final VoidCallback? onDismiss;

  /// If `true` the close button will be displayed. Default is `false`.
  final bool isDismissible;

  /// The custom action.
  final OptimusFeedbackLink? action;

  /// The variant of the alert which determines the background color and
  /// icon.
  final OptimusFeedbackVariant variant;

  /// An optional callback to be called when the alert is pressed.
  final VoidCallback? onPressed;

  /// The maximum width of the alert.
  final double maxWidth;

  /// The maximum number of lines for the title. If null, no limit is applied.
  final int? titleMaxLines;

  /// The maximum number of lines for the description. Default is 5.
  final int descriptionMaxLines;

  /// The maximum number of lines for the link text. Default is 1.
  final int linkMaxLines;

  /// The overflow style for all text in the alert. Default is [TextOverflow.ellipsis].
  final TextOverflow overflow;

  bool get _isExpanded => description != null || action != null;

  double _getHorizontalPadding(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).screenBreakpoint) {
        .small || .extraSmall => context.tokens.spacing100,
        .medium || .large || .extraLarge => context.tokens.spacing200,
      };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final horizontalPadding = _getHorizontalPadding(context);
    final double alertWidth = min(
      MediaQuery.sizeOf(context).width - horizontalPadding * 2,
      maxWidth,
    );

    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: .symmetric(
          horizontal: horizontalPadding,
          vertical: tokens.spacing50,
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: alertWidth),
            child: Stack(
              children: [
                _AlertContent(
                  icon: icon,
                  variant: variant,
                  title: title,
                  description: description,
                  linkText: action?.text,
                  onLinkPressed: () {
                    action?.onPressed();
                    OptimusAlertOverlay.of(context)?.remove(this);
                  },
                  isDismissible: isDismissible,
                  semanticLinkUri: action?.semanticUri,
                  titleMaxLines: titleMaxLines,
                  descriptionMaxLines: descriptionMaxLines,
                  linkMaxLines: linkMaxLines,
                  overflow: overflow,
                ),
                if (isDismissible)
                  Positioned(
                    top: _isExpanded ? tokens.spacing200 : tokens.spacing0,
                    right: tokens.spacing200,
                    bottom: _isExpanded ? null : tokens.spacing0,
                    child: FeedbackDismissButton(
                      onDismiss: () {
                        onDismiss?.call();
                        OptimusAlertOverlay.of(context)?.remove(this);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AlertContent extends StatelessWidget {
  const _AlertContent({
    this.icon,
    this.variant = OptimusFeedbackVariant.info,
    this.title,
    this.description,
    this.isDismissible = false,
    this.onLinkPressed,
    this.linkText,
    this.semanticLinkUri,
    this.titleMaxLines,
    this.descriptionMaxLines = 5,
    this.linkMaxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  });

  final IconData? icon;
  final OptimusFeedbackVariant variant;
  final Widget? title;
  final Widget? description;
  final Widget? linkText;
  final VoidCallback? onLinkPressed;
  final bool isDismissible;
  final Uri? semanticLinkUri;
  final int? titleMaxLines;
  final int descriptionMaxLines;
  final int linkMaxLines;
  final TextOverflow overflow;

  bool get _isExpanded => description != null || linkText != null;

  EdgeInsets _getContentPadding(OptimusTokens tokens) => isDismissible
      ? .fromLTRB(
          tokens.spacing200,
          tokens.spacing200,
          tokens.spacing400,
          tokens.spacing200,
        )
      : .all(tokens.spacing200);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final leadingSectionWidth =
        context.leadingIconSize + context.leadingIconHorizontalPadding * 2;
    final linkText = this.linkText;
    final onLinkPressed = this.onLinkPressed;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: .all(tokens.borderRadius100),
        boxShadow: tokens.shadow300,
      ),
      child: Stack(
        children: [
          Positioned(
            left: tokens.spacing0,
            bottom: tokens.spacing0,
            top: tokens.spacing0,
            width: leadingSectionWidth.toScaled(context),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: variant.backgroundColor(tokens),
                borderRadius: .horizontal(left: tokens.borderRadius100),
              ),
            ),
          ),
          Positioned(
            top: _isExpanded ? tokens.spacing200 : tokens.spacing0,
            bottom: _isExpanded ? null : tokens.spacing0,
            child: Padding(
              padding: .symmetric(horizontal: tokens.spacing100),
              child: FeedbackIcon(icon: icon, variant: variant),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: leadingSectionWidth.toScaled(context),
              ).excludeSemantics(),
              Expanded(
                child: Container(
                  padding: _getContentPadding(tokens),
                  decoration: BoxDecoration(
                    color: tokens.backgroundStaticFlat,
                    borderRadius: .horizontal(right: tokens.borderRadius100),
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    spacing: tokens.spacing50,
                    children: [
                      if (title case final title?)
                        FeedbackTitle(
                          title: title,
                          maxLines: titleMaxLines,
                          overflow: overflow,
                        ),
                      if (description case final description?)
                        FeedbackDescription(
                          description: description,
                          maxLines: descriptionMaxLines,
                          overflow: overflow,
                        ),
                      if (linkText != null && onLinkPressed != null)
                        FeedbackLink(
                          text: linkText,
                          onPressed: onLinkPressed,
                          semanticLinkUri: semanticLinkUri,
                          maxLines: linkMaxLines,
                          overflow: overflow,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on BuildContext {
  double get leadingIconSize => tokens.sizing300;
  double get leadingIconHorizontalPadding => tokens.sizing100;
}
