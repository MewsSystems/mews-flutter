import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/typography/presets.dart';

enum OptimusBannerVariant {
  /// To display an informative message.
  primary,

  /// To inform a user about a successful event.
  success,

  /// To display information that needs user attention.
  warning,

  /// To inform a user of potential danger or that something has gone wrong.
  error,
}

/// Contextual banners display a notification relevant to a specific
/// part of the system.
///
/// They appear at the top of the page or section they apply to, but always
/// below the page header or navigation. They don't cover content, but push it
/// down.
///
/// At its most basic, the component is comprised of a background
/// layer (colored according to the meaning of the message) and text;
/// other elements (left icon, description, link, close icon) are optional.
///
/// A banner always takes the full width of the component it is within.
class OptimusBanner extends StatelessWidget {
  const OptimusBanner({
    Key? key,
    required this.title,
    this.variant = OptimusBannerVariant.primary,
    this.hasIcon = false,
    this.description,
    this.isDismissible = false,
    this.onDismiss,
  }) : super(key: key);

  /// The title of the banner.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Variant of the banner which determines background color and icon
  /// (if [hasIcon] == true).
  final OptimusBannerVariant variant;

  /// If `true` the icon will be displayed. Which icon is used depends on
  /// [variant].
  final bool hasIcon;

  /// Banner's description rendered as a second line.
  ///
  /// Typically a [Text] widget.
  final Widget? description;

  /// If `true` close button will be rendered as well.
  ///
  /// It's your responsibility to process the button press with
  /// [onDismiss] callback parameter.
  final bool isDismissible;

  /// Called when close button is pressed (if [isDismissible] == true).
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor(theme),
        borderRadius: const BorderRadius.all(borderRadius50),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasIcon)
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: OptimusIcon(
                  iconData: _icon,
                  colorOption: _iconColor,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: description != null ? spacing50 : 10,
                            top: 9,
                          ),
                          child: DefaultTextStyle.merge(
                            child: title,
                            style: preset300s,
                          ),
                        ),
                      ),
                      if (isDismissible)
                        OptimusIconButton(
                          onPressed: () => onDismiss,
                          icon: const Icon(OptimusIcons.cross_close, size: 12),
                          size: OptimusWidgetSize.small,
                          variant: OptimusIconButtonVariant.bare,
                        ),
                    ],
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: spacing50,
                        bottom: 10,
                      ),
                      child: DefaultTextStyle.merge(
                        child: description!,
                        style: preset200r.copyWith(
                          color: _getDescriptionColor(theme),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusIcons.info;
      case OptimusBannerVariant.success:
        return OptimusIcons.done_circle;
      case OptimusBannerVariant.warning:
        return OptimusIcons.problematic;
      case OptimusBannerVariant.error:
        return OptimusIcons.blacklist;
    }
  }

  OptimusIconColorOption get _iconColor {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusIconColorOption.primary;
      case OptimusBannerVariant.success:
        return OptimusIconColorOption.success;
      case OptimusBannerVariant.warning:
        return OptimusIconColorOption.warning;
      case OptimusBannerVariant.error:
        return OptimusIconColorOption.danger;
    }
  }

  Color _backgroundColor(OptimusThemeData theme) {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return theme.colors.primary500t8;
      case OptimusBannerVariant.success:
        return theme.colors.success500t8;
      case OptimusBannerVariant.warning:
        return theme.colors.warning500t8;
      case OptimusBannerVariant.error:
        return theme.colors.danger500t8;
    }
  }

  Color _getDescriptionColor(OptimusThemeData theme) =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000t64;
}

enum OptimusWideBannerVariant {
  /// Used to notify users about crucial, but unproblematic, information.
  informative,

  /// Used to warn users about serious potential problems.
  warning,

  /// Used to inform users that there is a serious problem with the system.
  danger,
}

/// System-wide banners display critical notifications about the state of
/// the entire system.
///
/// They are placed at the top of the screen, above all content
/// (including navigation). Unlike contextual banners, system-wide banners
/// remain in the same place on all pages and cannot be dismissed.
///
/// System-wide banners display messages that are critical to the user
/// and affect how the system or user operates.
/// Because of their prominent appearance, they are used to communicate
/// only the most important information about the system. If overused,
/// users could stop perceiving them as something worth paying attention to.
/// System-wide banners must be removed when no longer necessary.
class OptimusWideBanner extends StatelessWidget {
  const OptimusWideBanner({
    Key? key,
    required this.content,
    this.variant = OptimusWideBannerVariant.informative,
  }) : super(key: key);

  /// Content of the banner.
  ///
  /// Typically a [Text] widget.
  final Widget content;

  /// Variant of the banner.
  ///
  /// Controls background color.
  final OptimusWideBannerVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      decoration: BoxDecoration(color: _backgroundColor(theme)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Icon(OptimusIcons.info, color: _color(theme)),
            ),
            DefaultTextStyle.merge(
              child: content,
              style: _contentTextStyle(theme),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _contentTextStyle(OptimusThemeData theme) =>
      preset200s.merge(TextStyle(color: _color(theme), height: 1));

  Color _backgroundColor(OptimusThemeData theme) {
    switch (variant) {
      case OptimusWideBannerVariant.informative:
        return theme.colors.primary500;
      case OptimusWideBannerVariant.warning:
        return theme.colors.warning500;
      case OptimusWideBannerVariant.danger:
        return theme.colors.danger500;
    }
  }

  Color _color(OptimusThemeData theme) {
    if (theme.brightness == Brightness.light) {
      switch (variant) {
        case OptimusWideBannerVariant.informative:
        case OptimusWideBannerVariant.danger:
          return theme.colors.neutral0;
        case OptimusWideBannerVariant.warning:
          return theme.colors.neutral1000;
      }
    } else {
      return theme.colors.neutral1000;
    }
  }
}
