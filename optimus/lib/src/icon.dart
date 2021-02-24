import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/colors/colors.dart';

enum OptimusIconSize {
  /// A small variant is used when space is limited.
  small,

  /// Considered the default option, used across all products and platforms.
  medium,

  /// Large icons should be used sparingly and only when there is enough space.
  large,
}

/// Icons are symbols that provide a visual representation of meaning in
/// situations where text is not enough or we want to emphasize its impact.
///
/// The default icon is used when there is no need for additional emphasis.
class OptimusIcon extends StatelessWidget {
  const OptimusIcon({
    Key key,
    @required this.iconData,
    this.iconSize = OptimusIconSize.medium,
    this.colorOption,
  }) : super(key: key);

  /// Controls the icon.
  final IconData iconData;

  /// Controls size of the icon.
  final OptimusIconSize iconSize;

  /// Controls color of the icon.
  ///
  /// - [null] – default value. Changes the color of the icon to match its
  ///   parent font color.
  /// - [OptimusColorOption.basic] – variant with no extra emphasis.
  /// - [OptimusColorOption.primary] – used to emphasize the item in a general
  ///   way.
  /// - [OptimusColorOption.success] – used to emphasize the item and convey
  ///   a sense of success.
  /// - [OptimusColorOption.warning] – used to emphasize the item and convey
  ///   a sense of warning.
  /// - [OptimusColorOption.danger] – used to emphasize the item and convey
  ///   a sense of danger or error.
  final OptimusColorOption colorOption;

  @override
  Widget build(BuildContext context) => Icon(
        iconData,
        color: colorOption == null
            ? DefaultTextStyle.of(context).style.color
            : colorOption.toIconColor(),
        size: _iconSize,
      );

  // ignore: missing_return
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
    Key key,
    @required this.iconData,
    this.colorOption = OptimusColorOption.basic,
  }) : super(key: key);

  /// Controls the icon.
  final IconData iconData;

  /// Controls the background color of the icon.
  ///
  /// - [null] – default value. Changes the color of the icon to match its
  ///   parent font color.
  /// - [OptimusColorOption.basic] – variant with no extra emphasis.
  /// - [OptimusColorOption.primary] – used to emphasize the item in a general
  ///   way.
  /// - [OptimusColorOption.success] – used to emphasize the item and convey
  ///   a sense of success.
  /// - [OptimusColorOption.warning] – used to emphasize the item and convey
  ///   a sense of warning.
  /// - [OptimusColorOption.danger] – used to emphasize the item and convey
  ///   a sense of danger or error.
  final OptimusColorOption colorOption;

  @override
  Widget build(BuildContext context) => Container(
        width: _diameter,
        height: _diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorOption.toSupplementaryBackgroundColor(),
        ),
        child: Icon(
          iconData,
          color: colorOption.toSupplementaryIconColor(),
          size: 32,
        ),
      );
}

extension on OptimusColorOption {
  // ignore: missing_return
  Color toIconColor() {
    switch (this) {
      case OptimusColorOption.basic:
        return OptimusLightColors.neutral500;
      case OptimusColorOption.primary:
        return OptimusLightColors.primary500;
      case OptimusColorOption.success:
        return OptimusLightColors.success500;
      case OptimusColorOption.warning:
        return OptimusLightColors.warning500;
      case OptimusColorOption.danger:
        return OptimusLightColors.danger500;
    }
  }

  // ignore: missing_return
  Color toSupplementaryIconColor() {
    switch (this) {
      case OptimusColorOption.basic:
        return OptimusLightColors.neutral500;
      case OptimusColorOption.warning:
        return OptimusLightColors.neutral900;
      default:
        return OptimusLightColors.neutral0;
    }
  }

  // ignore: missing_return
  Color toSupplementaryBackgroundColor() {
    switch (this) {
      case OptimusColorOption.basic:
        return OptimusLightColors.neutral50;
      case OptimusColorOption.primary:
        return OptimusLightColors.primary500;
      case OptimusColorOption.success:
        return OptimusLightColors.success500;
      case OptimusColorOption.warning:
        return OptimusLightColors.warning500;
      case OptimusColorOption.danger:
        return OptimusLightColors.danger500;
    }
  }
}

const double _diameter = 64;
