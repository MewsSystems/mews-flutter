import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

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
    super.key,
    required this.title,
    this.variant = OptimusBannerVariant.primary,
    this.hasIcon = false,
    this.description,
    this.isDismissible = false,
    this.onDismiss,
  });

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

  Color _getDescriptionColor(OptimusThemeData theme) =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000t64;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final tokens = context.tokens;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: variant.backgroundColor(theme),
        borderRadius: BorderRadius.circular(context.tokens.borderRadius100),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(tokens.spacing200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (hasIcon)
                  Padding(
                    padding: EdgeInsets.only(right: tokens.spacing200),
                    child: OptimusIcon(
                      iconData: variant.icon,
                      colorOption: variant.iconColor,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: isDismissible
                            ? EdgeInsets.only(right: tokens.spacing200)
                            : EdgeInsets.zero,
                        child: DefaultTextStyle.merge(
                          child: title,
                          style: tokens.bodyLargeStrong,
                        ),
                      ),
                      if (description case final description?)
                        Padding(
                          padding: EdgeInsets.only(top: tokens.spacing50),
                          child: DefaultTextStyle.merge(
                            child: description,
                            style: tokens.bodyMedium.copyWith(
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
          if (isDismissible)
            Positioned(
              top: tokens.spacing100,
              right: tokens.spacing100,
              child: OptimusIconButton(
                onPressed: onDismiss,
                icon: const Icon(OptimusIcons.cross_close),
                size: OptimusWidgetSize.small,
                variant: OptimusButtonVariant.ghost,
              ),
            ),
        ],
      ),
    );
  }
}

extension on OptimusBannerVariant {
  IconData get icon => switch (this) {
        OptimusBannerVariant.primary => OptimusIcons.info,
        OptimusBannerVariant.success => OptimusIcons.done_circle,
        OptimusBannerVariant.warning => OptimusIcons.problematic,
        OptimusBannerVariant.error => OptimusIcons.blacklist,
      };

  OptimusIconColorOption get iconColor => switch (this) {
        OptimusBannerVariant.primary => OptimusIconColorOption.primary,
        OptimusBannerVariant.success => OptimusIconColorOption.success,
        OptimusBannerVariant.warning => OptimusIconColorOption.warning,
        OptimusBannerVariant.error => OptimusIconColorOption.danger,
      };

  Color backgroundColor(OptimusThemeData theme) => switch (this) {
        OptimusBannerVariant.primary => theme.colors.primary500t8,
        OptimusBannerVariant.success => theme.colors.success500t8,
        OptimusBannerVariant.warning => theme.colors.warning500t8,
        OptimusBannerVariant.error => theme.colors.danger500t8,
      };
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
    super.key,
    required this.content,
    this.variant = OptimusWideBannerVariant.informative,
  });

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

    return DecoratedBox(
      decoration: BoxDecoration(color: _backgroundColor(theme)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ), // TODO(witwash): check with design
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
      theme.tokens.bodyMediumStrong
          .merge(TextStyle(color: _color(theme), height: 1));

  Color _backgroundColor(OptimusThemeData theme) => switch (variant) {
        OptimusWideBannerVariant.informative => theme.colors.primary500,
        OptimusWideBannerVariant.warning => theme.colors.warning500,
        OptimusWideBannerVariant.danger => theme.colors.danger500,
      };

  Color _lightColor(OptimusThemeData theme) => switch (variant) {
        OptimusWideBannerVariant.informative ||
        OptimusWideBannerVariant.danger =>
          theme.colors.neutral0,
        OptimusWideBannerVariant.warning => theme.colors.neutral1000,
      };

  Color _color(OptimusThemeData theme) => theme.brightness == Brightness.light
      ? _lightColor(theme)
      : theme.colors.neutral1000;
}
