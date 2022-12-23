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
    Key? key,
    required this.iconData,
    this.iconSize = OptimusIconSize.medium,
    this.colorOption,
  }) : super(key: key);

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

  double get _iconSize {
    switch (iconSize) {
      case OptimusIconSize.small:
        return 16;
      case OptimusIconSize.medium:
        return 24;
      case OptimusIconSize.large:
        return 32;
    }
  }
}

/// Icons are symbols that provide a visual representation of meaning in
/// situations where text is not enough or we want to emphasize its impact.
///
/// Supplementary icon is used when it's necessary to highlight information or
/// provide additional emphasis.
class OptimusSupplementaryIcon extends StatelessWidget {
  const OptimusSupplementaryIcon({
    Key? key,
    required this.iconData,
    this.colorOption = OptimusIconColorOption.basic,
  }) : super(key: key);

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
  Color toIconColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusIconColorOption.basic:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500;
      case OptimusIconColorOption.primary:
        return theme.colors.primary500;
      case OptimusIconColorOption.success:
        return theme.colors.success500;
      case OptimusIconColorOption.info:
        return theme.colors.info500;
      case OptimusIconColorOption.warning:
        return theme.colors.warning700;
      case OptimusIconColorOption.danger:
        return theme.colors.danger500;
      case OptimusIconColorOption.subtle:
        return theme.colors.neutral300;
    }
  }

  Color toSupplementaryIconColor(OptimusThemeData theme) {
    if (theme.isDark) return theme.colors.neutral1000;

    switch (this) {
      case OptimusIconColorOption.basic:
        return theme.colors.neutral500;
      case OptimusIconColorOption.warning:
        return theme.colors.neutral1000;
      default:
        return theme.colors.neutral0;
    }
  }

  Color toSupplementaryBackgroundColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusIconColorOption.basic:
        return theme.colors.neutral50;
      case OptimusIconColorOption.primary:
        return theme.colors.primary500;
      case OptimusIconColorOption.success:
        return theme.colors.success500;
      case OptimusIconColorOption.info:
        return theme.colors.info500;
      case OptimusIconColorOption.warning:
        return theme.colors.warning500;
      case OptimusIconColorOption.danger:
        return theme.colors.danger500;
      case OptimusIconColorOption.subtle:
        // TODO(VG): Add proper color when design is ready.
        return theme.colors.neutral50;
    }
  }
}

const double _diameter = 64;
