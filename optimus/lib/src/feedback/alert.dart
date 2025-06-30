import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/semantics.dart';
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

  bool get _isExpanded => description != null || action != null;

  double _getHorizontalPadding(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).screenBreakpoint) {
        Breakpoint.small || Breakpoint.extraSmall => context.tokens.spacing100,
        Breakpoint.medium ||
        Breakpoint.large ||
        Breakpoint.extraLarge => context.tokens.spacing200,
      };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final horizontalPadding = _getHorizontalPadding(context);
    final double alertWidth = min(
      MediaQuery.sizeOf(context).width - horizontalPadding * 2,
      _maxWidth,
    );

    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
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
  });

  final IconData? icon;
  final OptimusFeedbackVariant variant;
  final Widget? title;
  final Widget? description;
  final Widget? linkText;
  final VoidCallback? onLinkPressed;
  final bool isDismissible;
  final Uri? semanticLinkUri;

  bool get _isExpanded => description != null || linkText != null;

  EdgeInsets _getContentPadding(OptimusTokens tokens) =>
      isDismissible
          ? EdgeInsets.fromLTRB(
            tokens.spacing200,
            tokens.spacing200,
            tokens.spacing400,
            tokens.spacing200,
          )
          : EdgeInsets.all(tokens.spacing200);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final leadingSectionWidth = tokens.sizing300 + tokens.spacing100 * 2;
    final linkText = this.linkText;
    final onLinkPressed = this.onLinkPressed;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(tokens.borderRadius100),
        boxShadow: tokens.shadow300,
      ),
      child: Stack(
        children: [
          Positioned(
            left: tokens.spacing0,
            bottom: tokens.spacing0,
            top: tokens.spacing0,
            width: leadingSectionWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: variant.backgroundColor(tokens),
                borderRadius: BorderRadius.horizontal(
                  left: tokens.borderRadius100,
                ),
              ),
            ),
          ),
          Positioned(
            top: _isExpanded ? tokens.spacing200 : tokens.spacing0,
            bottom: _isExpanded ? null : tokens.spacing0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: tokens.spacing100),
              child: FeedbackIcon(icon: icon, variant: variant),
            ),
          ),
          Row(
            children: [
              SizedBox(width: leadingSectionWidth).excludeSemantics(),
              Expanded(
                child: Container(
                  padding: _getContentPadding(tokens),
                  decoration: BoxDecoration(
                    color: tokens.backgroundStaticFlat,
                    borderRadius: BorderRadius.horizontal(
                      right: tokens.borderRadius100,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: tokens.spacing50,
                    children: [
                      if (title case final title?) FeedbackTitle(title: title),
                      if (description case final description?)
                        FeedbackDescription(description: description),
                      if (linkText != null && onLinkPressed != null)
                        FeedbackLink(
                          text: linkText,
                          onPressed: onLinkPressed,
                          semanticLinkUri: semanticLinkUri,
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

const double _maxWidth = 360;
