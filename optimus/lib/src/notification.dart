import 'dart:math';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/elevation.dart';
import 'package:optimus/src/typography/presets.dart';

const double _kMaxWidth = 360;
const double _kCloseIconSize = 16;
const double _kIconSize = 20;
const double _kIconHorizontalPadding = 10;
const int _kMaxLinesTitle = 1;
const int _kMaxLinesDescription = 5;
const int _kMaxLinesLink = 1;

/// Describes certain type of notification with it's semantical meaning.
/// Use-cases:
///  - [OptimusNotificationVariant.info] -  Used for notifying about
/// informational, supportive, educative matter.
///  - [OptimusNotificationVariant.success] - Used for notifying about
/// successful, confirming, positive matter.
///  - [OptimusNotificationVariant.warning] - Used for notifying about
/// warning, problematic or matter that require user's attention.
///  - [OptimusNotificationVariant.danger] - Used for notifying about dangerous
/// matter. Could be error, destructive action or negative feedback.
enum OptimusNotificationVariant {
  info,
  success,
  warning,
  danger,
}

extension on OptimusNotificationVariant {
  Color getBannerColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusNotificationVariant.info:
        return theme.colors.info500;
      case OptimusNotificationVariant.success:
        return theme.colors.success500;
      case OptimusNotificationVariant.warning:
        return theme.colors.warning500;
      case OptimusNotificationVariant.danger:
        return theme.colors.danger500;
    }
  }

  IconData getBannerIcon() {
    switch (this) {
      case OptimusNotificationVariant.info:
        return OptimusIcons.info;
      case OptimusNotificationVariant.success:
        return OptimusIcons.done_circle;
      case OptimusNotificationVariant.warning:
        return OptimusIcons.problematic;
      case OptimusNotificationVariant.danger:
        return OptimusIcons.blacklist;
    }
  }

  Color getBannerIconColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusNotificationVariant.info:
      case OptimusNotificationVariant.success:
      case OptimusNotificationVariant.danger:
        return theme.colors.neutral0;
      case OptimusNotificationVariant.warning:
        return theme.colors.neutral1000;
    }
  }
}

/// Notification are used for showing brief and concise message that
/// communicates immediate feedback with optional action included. Notifications
/// are noticeable but not intrusive to the use and can be temporary.
class OptimusNotification extends StatelessWidget {
  const OptimusNotification({
    Key? key,
    required this.title,
    this.icon,
    this.link,
    this.onLinkPressed,
    this.description,
    this.isDismissible = false,
    this.onDismiss,
    this.variant = OptimusNotificationVariant.info,
  }) : super(key: key);

  final String title;
  final IconData? icon;
  final String? link;
  final VoidCallback? onLinkPressed;
  final String? description;
  final bool isDismissible;
  final VoidCallback? onDismiss;
  final OptimusNotificationVariant variant;

  Widget _closeIcon(OptimusThemeData theme) => GestureDetector(
        onTap: () => onDismiss?.call(),
        child: Padding(
          padding: const EdgeInsets.all(spacing100),
          child: Icon(
            OptimusIcons.cross_close,
            color: theme.colors.neutral500,
            size: _kCloseIconSize,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final OptimusThemeData theme = OptimusTheme.of(context);
    final Breakpoint screenBreakpoint = MediaQuery.of(context).screenBreakpoint;
    final padding = screenBreakpoint.getPadding();
    final double notificationWidth = min(
      MediaQuery.of(context).size.width - padding * 2,
      _kMaxWidth,
    );

    return Positioned(
      top: padding,
      right: padding,
      child: Container(
        constraints: BoxConstraints(maxWidth: notificationWidth),
        decoration: BoxDecoration(
          color: variant.getBannerColor(theme),
          borderRadius: const BorderRadius.all(borderRadius50),
          boxShadow: elevation50,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: _kIconHorizontalPadding),
                  child: Icon(
                    icon ?? variant.getBannerIcon(),
                    color: variant.getBannerIconColor(theme),
                    size: _kIconSize,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(spacing200),
                    decoration: BoxDecoration(
                      color: theme.colors.neutral0,
                      borderRadius: const BorderRadius.horizontal(
                        right: borderRadius50,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          maxLines: _kMaxLinesTitle,
                          overflow: TextOverflow.ellipsis,
                          style: preset300b.copyWith(
                            color: theme.colors.neutral1000,
                          ),
                        ),
                        if (description != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: spacing50,
                            ),
                            child: Text(
                              description!,
                              maxLines: _kMaxLinesDescription,
                              overflow: TextOverflow.ellipsis,
                              style: preset200r.copyWith(
                                color: theme.colors.neutral1000t64,
                              ),
                            ),
                          ),
                        if (link != null)
                          GestureDetector(
                            onTap: () => onLinkPressed?.call(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: spacing50,
                              ),
                              child: Text(
                                link!,
                                maxLines: _kMaxLinesLink,
                                overflow: TextOverflow.ellipsis,
                                style: preset200b.copyWith(
                                  color: theme.colors.neutral1000,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isDismissible)
              Positioned(
                right: spacing100,
                top: spacing100,
                child: _closeIcon(theme),
              )
          ],
        ),
      ),
    );
  }
}

extension on Breakpoint {
  double getPadding() {
    switch (this) {
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return spacing200;
      case Breakpoint.small:
      case Breakpoint.extraSmall:
        return spacing100;
    }
  }
}
