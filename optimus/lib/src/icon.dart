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
  inverse,
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
  /// - [OptimusIconColorOption.inverse] – used to emphasize the item in a
  ///  general way, but with an inverse color.
  final OptimusIconColorOption? colorOption;

  double _getIconSize(OptimusTokens tokens) => switch (iconSize) {
        OptimusIconSize.small => tokens.sizing200,
        OptimusIconSize.medium => tokens.sizing300,
        OptimusIconSize.large => tokens.sizing400,
      };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Icon(
      iconData,
      color: colorOption?.let((option) => option.toIconColor(tokens)) ??
          tokens.textStaticPrimary,
      size: _getIconSize(context.tokens),
    );
  }
}

extension on OptimusIconColorOption {
  Color toIconColor(OptimusTokens tokens) => switch (this) {
        OptimusIconColorOption.basic => tokens.textStaticPrimary,
        OptimusIconColorOption.primary => tokens.textInteractivePrimaryDefault,
        OptimusIconColorOption.success => tokens.textAlertSuccess,
        OptimusIconColorOption.info => tokens.textAlertInfo,
        OptimusIconColorOption.warning => tokens.textAlertWarning,
        OptimusIconColorOption.danger => tokens.textAlertDanger,
        OptimusIconColorOption.inverse => tokens.textStaticInverse,
      };
}
