import 'dart:math';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/elevation.dart';
import 'package:optimus/src/typography/presets.dart';

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
}

/// Notification are used for showing brief and concise message that
/// communicates immediate feedback with optional action included. Notifications
/// are noticeable but not intrusive to the use and can be temporary.
class OptimusNotification extends StatefulWidget {
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

  @override
  State<OptimusNotification> createState() => _OptimusNotificationState();
}

class _OptimusNotificationState extends State<OptimusNotification>
    with ThemeGetter {
  Widget get _closeIcon => GestureDetector(
        onTap: () => widget.onDismiss,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            OptimusIcons.cross_close,
            color: theme.colors.neutral500,
            size: 16,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final double notificationWidth =
        min(MediaQuery.of(context).size.width - spacing200, 360);

    return Container(
      constraints: BoxConstraints(maxWidth: notificationWidth),
      decoration: BoxDecoration(
        color: widget.variant.getBannerColor(theme),
        borderRadius: const BorderRadius.all(borderRadius50),
        boxShadow: elevation50,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: spacing100),
                child: Icon(
                  widget.icon ?? widget.variant.getBannerIcon(),
                  color: theme.colors.neutral0,
                  size: 24,
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: spacing100,
                          bottom: spacing50,
                        ),
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: preset300b.copyWith(
                            color: theme.colors.neutral1000,
                          ),
                        ),
                      ),
                      if (widget.description != null)
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: spacing50),
                          child: Text(
                            widget.description!,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: preset200r.copyWith(
                              color: theme.colors.neutral1000t64,
                            ),
                          ),
                        ),
                      if (widget.link != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: spacing50,
                          ),
                          child: Text(
                            widget.link!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: preset200b.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (widget.isDismissible)
            Positioned(right: spacing100, top: spacing100, child: _closeIcon)
        ],
      ),
    );
  }
}
