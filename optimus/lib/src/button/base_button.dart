import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/constants.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/widget_size.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key key,
    this.onPressed,
    @required this.child,
    this.minWidth,
    this.leftIcon,
    this.rightIcon,
    this.badgeLabel,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.defaultButton,
    this.borderRadius = const BorderRadius.all(borderRadius50),
  }) : super(key: key);

  final VoidCallback onPressed;

  final Widget child;

  final double minWidth;

  final IconData leftIcon;

  final IconData rightIcon;

  final String badgeLabel;

  final OptimusWidgetSize size;

  final OptimusButtonVariant variant;

  final BorderRadius borderRadius;

  Widget _buildIcon(IconData icon) =>
      Icon(icon, size: _iconSize, color: _textColor);

  TextStyle get _textStyle =>
      size == OptimusWidgetSize.small ? preset200s : preset300s;

  Widget _buildBadgeLabel(String badgeLabel) => SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 16,
            color: _textColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing50),
              child: Text(
                badgeLabel,
                style: preset100s.copyWith(color: _badgeTextColor, height: 1.3),
              ),
            ),
          ),
        ),
      );

  // ignore: missing_return
  double get _iconSize {
    switch (size) {
      case OptimusWidgetSize.small:
        return 16;
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return 24;
    }
  }

  // ignore: missing_return
  Color get _color {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusLightColors.neutral50;
      case OptimusButtonVariant.primary:
        return OptimusLightColors.primary500;
      case OptimusButtonVariant.text:
        return Colors.transparent;
      case OptimusButtonVariant.destructive:
        return OptimusLightColors.danger500;
      case OptimusButtonVariant.warning:
        return OptimusLightColors.warning500;
    }
  }

  // ignore: missing_return
  Color get _badgeTextColor {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusLightColors.neutral50;
      case OptimusButtonVariant.primary:
        return OptimusLightColors.primary500;
      case OptimusButtonVariant.text:
        return OptimusLightColors.neutral0;
      case OptimusButtonVariant.destructive:
        return OptimusLightColors.danger500;
      case OptimusButtonVariant.warning:
        return OptimusLightColors.warning500;
    }
  }

  // ignore: missing_return
  Color get _hoverColor {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusLightColors.neutral100;
      case OptimusButtonVariant.primary:
        return OptimusLightColors.primary700;
      case OptimusButtonVariant.text:
        return OptimusLightColors.neutral500t8;
      case OptimusButtonVariant.destructive:
        return OptimusLightColors.danger700;
      case OptimusButtonVariant.warning:
        return OptimusLightColors.warning700;
    }
  }

  // ignore: missing_return
  Color get _highLightColor {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusLightColors.neutral200;
      case OptimusButtonVariant.primary:
        return OptimusLightColors.primary900;
      case OptimusButtonVariant.text:
        return OptimusLightColors.neutral500t16;
      case OptimusButtonVariant.destructive:
        return OptimusLightColors.danger900;
      case OptimusButtonVariant.warning:
        return OptimusLightColors.warning900;
    }
  }

  // ignore: missing_return
  Color get _textColor {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusLightColors.neutral500;
      case OptimusButtonVariant.primary:
        return OptimusLightColors.neutral0;
      case OptimusButtonVariant.text:
        return OptimusLightColors.neutral500;
      case OptimusButtonVariant.destructive:
        return OptimusLightColors.neutral0;
      case OptimusButtonVariant.warning:
        return OptimusLightColors.neutral900;
    }
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity:
            onPressed != null ? OpacityValue.enabled : OpacityValue.disabled,
        child: MaterialButton(
          minWidth: minWidth,
          height: size.value,
          elevation: 0,
          highlightElevation: 0,
          highlightColor: _highLightColor,
          disabledColor: _color,
          disabledTextColor: _textColor,
          hoverElevation: 0,
          splashColor: Colors.transparent,
          hoverColor: _hoverColor,
          onPressed: onPressed,
          animationDuration: buttonAnimationDuration,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          color: _color,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (leftIcon != null) _buildIcon(leftIcon),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacing100),
                child: DefaultTextStyle.merge(
                  child: child,
                  style: _textStyle.copyWith(color: _textColor, height: 1),
                ),
              ),
              if (rightIcon != null) _buildIcon(rightIcon),
              if (badgeLabel != null && badgeLabel.isNotEmpty)
                _buildBadgeLabel(badgeLabel),
            ],
          ),
        ),
      );
}
