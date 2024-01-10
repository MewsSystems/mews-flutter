import 'dart:math';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// Describes a certain type of notification with its semantical meaning.
///
/// Use-cases:
///  - [OptimusNotificationVariant.info] -  Used for notifying about
/// informational, supportive, educative matter.
///  - [OptimusNotificationVariant.success] - Used for notifying about
/// successful, confirming, positive matter.
///  - [OptimusNotificationVariant.warning] -  Used for notifying about
/// warnings, problems, or matters that require the user's attention.
///  - [OptimusNotificationVariant.danger] - Used for notifying about the
/// dangerous matter. Could be error, destructive action or negative feedback.
enum OptimusNotificationVariant {
  info,
  success,
  warning,
  danger,
}

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
    this.variant = OptimusNotificationVariant.info,
  });

  final Widget title;
  final Widget? body;
  final IconData? icon;
  final VoidCallback? onDismissed;
  final OptimusNotificationLink? link;
  final OptimusNotificationVariant variant;

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

/// The notification link with custom action.
///
/// This link is defined by the [text] widget, usually [Text] and the
/// function that will be executed after a click. After clicking on the link,
/// notification will be dismissed.
class OptimusNotificationLink {
  const OptimusNotificationLink({
    required this.text,
    required this.onPressed,
  });

  final Widget text;
  final VoidCallback onPressed;
}

/// Optimus styled notification title.
///
/// Title should be straight and easy-to-understand.
class _NotificationTitle extends StatelessWidget {
  const _NotificationTitle(this.title);

  final Widget title;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return DefaultTextStyle(
      style: preset300b.copyWith(
        color: theme.colors.neutral1000,
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
    final theme = OptimusTheme.of(context);

    return DefaultTextStyle(
      maxLines: _maxLinesBody,
      overflow: TextOverflow.ellipsis,
      style: preset200r.copyWith(
        color: theme.colors.neutral1000t64,
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
    final theme = OptimusTheme.of(context);

    return DefaultTextStyle(
      maxLines: _maxLinesLink,
      overflow: TextOverflow.ellipsis,
      style: preset200b.copyWith(
        color: theme.colors.neutral1000,
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
  final OptimusNotificationVariant variant;
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
    final theme = OptimusTheme.of(context);
    final body = this.body;
    final link = this.link;
    final tokens = context.tokens;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tokens.borderRadius50),
        boxShadow: context.tokens.shadow200,
      ),
      child: Stack(
        children: [
          Positioned(
            left: tokens.spacing0,
            bottom: tokens.spacing0,
            top: tokens.spacing0,
            width: _leadingSectionWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: variant.getBannerColor(theme),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(tokens.borderRadius50),
                ),
              ),
              child: _LeadingIcon(icon: icon, variant: variant),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: _leadingSectionWidth),
              Expanded(
                child: Container(
                  padding: _getContentPadding(tokens),
                  decoration: BoxDecoration(
                    color: theme.colors.neutral0,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(tokens.borderRadius50),
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
  final OptimusNotificationVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _iconHorizontalPadding,
      ),
      child: Icon(
        icon ?? variant.bannerIcon,
        color: variant.getBannerIconColor(theme),
        size: _iconSize,
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
    final theme = OptimusTheme.of(context);
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
            color: theme.colors.neutral500,
            size: _closeIconSize,
          ),
        ),
      ),
    );
  }
}

extension on OptimusNotificationVariant {
  Color getBannerColor(OptimusThemeData theme) => switch (this) {
        OptimusNotificationVariant.info => theme.colors.info500,
        OptimusNotificationVariant.success => theme.colors.success500,
        OptimusNotificationVariant.warning => theme.colors.warning500,
        OptimusNotificationVariant.danger => theme.colors.danger500,
      };

  Color getBannerIconColor(OptimusThemeData theme) => switch (this) {
        OptimusNotificationVariant.info ||
        OptimusNotificationVariant.success ||
        OptimusNotificationVariant.danger =>
          theme.colors.neutral0,
        OptimusNotificationVariant.warning => theme.colors.neutral1000,
      };

  IconData get bannerIcon => switch (this) {
        OptimusNotificationVariant.info => OptimusIcons.info,
        OptimusNotificationVariant.success => OptimusIcons.done_circle,
        OptimusNotificationVariant.warning => OptimusIcons.problematic,
        OptimusNotificationVariant.danger => OptimusIcons.blacklist,
      };
}

const double _maxWidth = 360;
const double _closeIconSize = 16;
const double _iconSize = 20;
const double _iconHorizontalPadding = 10;
const int _maxLinesBody = 5;
const int _maxLinesLink = 1;
const double _leadingSectionWidth = _iconSize + _iconHorizontalPadding * 2;
