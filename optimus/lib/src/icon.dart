import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

enum OptimusIconSize {
  /// A small variant is used when space is limited.
  small,

  /// Considered the default option, used across all products and platforms.
  medium,

  /// Large icons should be used sparingly and only when there is enough space.
  large,
}

enum OptimusIconColorOption {
  basic,
  primary,
  success,
  info,
  warning,
  danger,
  subtle,
}

/// Icons are symbols that provide a visual representation of meaning in
/// situations where text is not enough or we want to emphasize its impact.
///
/// The default icon is used when there is no need for additional emphasis.
class OptimusIcon extends StatelessWidget {
  const OptimusIcon({
    super.key,
    required this.iconData,
    this.iconSize = OptimusIconSize.medium,
    this.colorOption,
  });

  /// Controls the icon.
  final IconData iconData;

  /// Controls size of the icon.
  final OptimusIconSize iconSize;

  /// Controls color of the icon.
  ///
  /// - `null` – default value. Changes the color of the icon to match its
  ///   parent font color.
  /// - [OptimusIconColorOption.basic] – variant with no extra emphasis.
  /// - [OptimusIconColorOption.primary] – used to emphasize the item in a
  ///   general way.
  /// - [OptimusIconColorOption.success] – used to emphasize the item and convey
  ///   a sense of success.
  /// - [OptimusIconColorOption.warning] – used to emphasize the item and convey
  ///   a sense of warning.
  /// - [OptimusIconColorOption.danger] – used to emphasize the item and convey
  ///   a sense of danger or error.
  final OptimusIconColorOption? colorOption;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Icon(
      iconData,
      color: colorOption?.let((option) => option.toIconColor(theme)) ??
          theme.colors.defaultTextColor,
      size: _iconSize,
    );
  }

  double get _iconSize => switch (iconSize) {
        OptimusIconSize.small => 16,
        OptimusIconSize.medium => 24,
        OptimusIconSize.large => 32,
      };
}

/// Icons are symbols that provide a visual representation of meaning in
/// situations where text is not enough or we want to emphasize its impact.
///
/// Supplementary icon is used when it's necessary to highlight information or
/// provide additional emphasis.
class OptimusSupplementaryIcon extends StatelessWidget {
  const OptimusSupplementaryIcon({
    super.key,
    required this.iconData,
    this.colorOption = OptimusIconColorOption.basic,
  });

  /// Controls the icon.
  final IconData iconData;

  /// Controls color of the icon.
  ///
  /// - `null` – default value. Changes the color of the icon to match its
  ///   parent font color.
  /// - [OptimusIconColorOption.basic] – variant with no extra emphasis.
  /// - [OptimusIconColorOption.primary] – used to emphasize the item in a
  ///   general way.
  /// - [OptimusIconColorOption.success] – used to emphasize the item and convey
  ///   a sense of success.
  /// - [OptimusIconColorOption.warning] – used to emphasize the item and convey
  ///   a sense of warning.
  /// - [OptimusIconColorOption.danger] – used to emphasize the item and convey
  ///   a sense of danger or error.
  final OptimusIconColorOption colorOption;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorOption.toSupplementaryBackgroundColor(theme),
      ),
      child: Icon(
        iconData,
        color: colorOption.toSupplementaryIconColor(theme),
        size: 32,
      ),
    );
  }
}

extension on OptimusIconColorOption {
  Color toIconColor(OptimusThemeData theme) => switch (this) {
        OptimusIconColorOption.basic =>
          theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500,
        OptimusIconColorOption.primary => theme.colors.primary500,
        OptimusIconColorOption.success => theme.colors.success500,
        OptimusIconColorOption.info => theme.colors.info500,
        OptimusIconColorOption.warning => theme.colors.warning700,
        OptimusIconColorOption.danger => theme.colors.danger500,
        OptimusIconColorOption.subtle => theme.colors.neutral300,
      };

  Color toSupplementaryIconColor(OptimusThemeData theme) {
    if (theme.isDark) return theme.colors.neutral1000;

    return switch (this) {
      OptimusIconColorOption.basic => theme.colors.neutral500,
      OptimusIconColorOption.warning => theme.colors.neutral1000,
      OptimusIconColorOption.danger ||
      OptimusIconColorOption.primary ||
      OptimusIconColorOption.success ||
      OptimusIconColorOption.info ||
      OptimusIconColorOption.subtle =>
        theme.colors.neutral0,
    };
  }

  Color toSupplementaryBackgroundColor(OptimusThemeData theme) =>
      switch (this) {
        OptimusIconColorOption.basic ||
        OptimusIconColorOption.subtle =>
          theme.colors.neutral50,
        OptimusIconColorOption.primary => theme.colors.primary500,
        OptimusIconColorOption.success => theme.colors.success500,
        OptimusIconColorOption.info => theme.colors.info500,
        OptimusIconColorOption.warning => theme.colors.warning500,
        OptimusIconColorOption.danger => theme.colors.danger500,
      };
}

const double _diameter = 64;
