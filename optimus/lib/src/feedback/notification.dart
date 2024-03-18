import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/feedback/common.dart';

/// Notification is used for showing a brief and concise message that
/// communicates immediate feedback with optional action included. Notifications
/// are noticeable but not intrusive to the use and can be temporary.
class OptimusNotification extends StatelessWidget {
  const OptimusNotification({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.link,
    this.onDismissed,
    this.variant = OptimusFeedbackVariant.info,
  });

  /// The title of the notification.
  final Widget title;

  /// The main content or description which should be as brief and straight
  /// to the point.
  final Widget? description;

  /// The icon that will be displayed on the left side of the notification.
  final IconData? icon;

  /// The dismissible callback that will be executed after a click on the close
  /// button.
  final VoidCallback? onDismissed;

  /// The link with custom action.
  final OptimusFeedbackLink? link;

  /// The variant of the notification which determines the background color and
  /// icon.
  final OptimusFeedbackVariant variant;

  bool get _isExpanded => description != null || link != null;

  double _getPadding(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).screenBreakpoint) {
        Breakpoint.small || Breakpoint.extraSmall => context.tokens.spacing100,
        Breakpoint.medium ||
        Breakpoint.large ||
        Breakpoint.extraLarge =>
          context.tokens.spacing200,
      };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final padding = _getPadding(context);
    final double notificationWidth =
        min(MediaQuery.sizeOf(context).width - padding * 2, _maxWidth);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: notificationWidth),
        child: Stack(
          children: [
            _NotificationContent(
              icon: icon,
              variant: variant,
              title: title,
              description: description,
              linkText: link?.text,
              onLinkPressed: () {
                link?.onPressed();
                OptimusNotificationsOverlay.of(context)?.remove(this);
              },
              dismissible: onDismissed != null,
            ),
            if (onDismissed != null)
              Positioned(
                top: _isExpanded ? tokens.spacing200 : tokens.spacing0,
                right: tokens.spacing200,
                bottom: _isExpanded ? null : tokens.spacing0,
                child: FeedbackDismissButton(
                  onDismissed: () {
                    onDismissed?.call();
                    OptimusNotificationsOverlay.of(context)?.remove(this);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationContent extends StatelessWidget {
  const _NotificationContent({
    required this.icon,
    required this.variant,
    required this.title,
    required this.description,
    required this.dismissible,
    this.onLinkPressed,
    this.linkText,
  });

  final IconData? icon;
  final OptimusFeedbackVariant variant;
  final Widget title;
  final Widget? description;
  final Widget? linkText;
  final VoidCallback? onLinkPressed;
  final bool dismissible;

  bool get _isExpanded => description != null || linkText != null;

  EdgeInsets _getContentPadding(OptimusTokens tokens) => dismissible
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
              SizedBox(width: leadingSectionWidth),
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
                    children: [
                      FeedbackTitle(title: title),
                      if (description case final description?)
                        Padding(
                          padding: EdgeInsets.only(top: tokens.spacing50),
                          child: FeedbackDescription(description: description),
                        ),
                      if (linkText != null && onLinkPressed != null)
                        Padding(
                          padding: EdgeInsets.only(top: tokens.spacing50),
                          child: FeedbackLink(
                            text: linkText,
                            onPressed: onLinkPressed,
                          ),
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
