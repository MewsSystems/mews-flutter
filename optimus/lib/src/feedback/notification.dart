import 'dart:math';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/feedback/feedback_link.dart';

/// Notification is used for showing a brief and concise message that
/// communicates immediate feedback with optional action included. Notifications
/// are noticeable but not intrusive to the use and can be temporary.
class OptimusNotification extends StatelessWidget {
  const OptimusNotification({
    super.key,
    required this.title,
    this.body,
    this.icon,
    this.link,
    this.onDismissed,
    this.variant = OptimusFeedbackVariant.info,
  });

  /// The title of the notification.
  final Widget title;

  /// The main content or description which should be as brief and straight
  /// to the point. Number or lines is limited to [_maxLinesBody].
  final Widget? body;

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
    final padding = _getPadding(context);
    final double notificationWidth =
        min(MediaQuery.sizeOf(context).width - padding * 2, _maxWidth);
    final dismiss = onDismissed;
    final bool isDismissible = dismiss != null;

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
              body: body,
              link: link?.text,
              onLinkPressed: () {
                link?.onPressed();
                OptimusNotificationsOverlay.of(context)?.remove(this);
              },
              dismissible: isDismissible,
            ),
            if (isDismissible)
              _NotificationCloseButton(
                onDismissed: () {
                  dismiss();
                  OptimusNotificationsOverlay.of(context)?.remove(this);
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// Optimus styled notification title.
///
/// Title should be straight and easy-to-understand.
class _NotificationTitle extends StatelessWidget {
  const _NotificationTitle(this.title);

  final Widget title;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle(
      style: tokens.bodyMediumStrong.copyWith(
        color: tokens.textStaticPrimary,
      ),
      child: title,
    );
  }
}

/// Optimus styled notification body.
///
/// The main content or description should be as brief and straight to the point
/// as possible. Number or lines is limited to [_maxLinesBody] and is truncated
/// with ellipsis.
class _NotificationBody extends StatelessWidget {
  const _NotificationBody(this.body);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle(
      maxLines: _maxLinesBody,
      overflow: TextOverflow.ellipsis,
      style: tokens.bodyMedium.copyWith(
        color: tokens.textStaticSecondary,
      ),
      child: body,
    );
  }
}

/// Optimus styled notification link.
///
/// Link should be short and precise. Number of lines is limited
/// to [_maxLinesLink]
class _NotificationLink extends StatelessWidget {
  const _NotificationLink(this.link);

  final Widget link;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle(
      maxLines: _maxLinesLink,
      overflow: TextOverflow.ellipsis,
      style: tokens.bodyMedium.copyWith(
        color: tokens.textStaticPrimary,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
      child: link,
    );
  }
}

class _NotificationContent extends StatelessWidget {
  const _NotificationContent({
    required this.icon,
    required this.variant,
    required this.title,
    required this.body,
    required this.link,
    required this.onLinkPressed,
    required this.dismissible,
  });

  final IconData? icon;
  final OptimusFeedbackVariant variant;
  final Widget title;
  final Widget? body;
  final Widget? link;
  final VoidCallback? onLinkPressed;
  final bool dismissible;

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
    final body = this.body;
    final link = this.link;
    final leadingSectionWidth = tokens.sizing300 + tokens.spacing100 * 2;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tokens.borderRadius100),
        boxShadow: context.tokens.shadow300,
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
                  left: Radius.circular(tokens.borderRadius100),
                ),
              ),
            ),
          ),
          Positioned(
            top: tokens.spacing200,
            child: _LeadingIcon(icon: icon, variant: variant),
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
                      right: Radius.circular(tokens.borderRadius100),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NotificationTitle(title),
                      if (body != null)
                        Padding(
                          padding: EdgeInsets.only(top: tokens.spacing50),
                          child: _NotificationBody(body),
                        ),
                      if (link != null)
                        Padding(
                          padding: EdgeInsets.only(top: tokens.spacing50),
                          child: GestureDetector(
                            onTap: onLinkPressed,
                            child: _NotificationLink(link),
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

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({
    required this.icon,
    required this.variant,
  });

  final IconData? icon;
  final OptimusFeedbackVariant variant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing100),
      child: Icon(
        icon ?? variant.icon,
        color: variant.getIconColor(tokens),
        size: context.tokens.sizing300,
      ),
    );
  }
}

class _NotificationCloseButton extends StatelessWidget {
  const _NotificationCloseButton({
    required this.onDismissed,
  });

  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Positioned(
      top: tokens.spacing100,
      right: tokens.spacing100,
      child: GestureDetector(
        onTap: onDismissed,
        child: Padding(
          padding: EdgeInsets.all(tokens.spacing100),
          child: Icon(
            OptimusIcons.cross_close,
            color: tokens.textStaticPrimary,
            size: tokens.sizing200,
          ),
        ),
      ),
    );
  }
}

const double _maxWidth = 360;
const int _maxLinesBody = 5;
const int _maxLinesLink = 1;
