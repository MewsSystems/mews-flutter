import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/typography/presets.dart';

class BaseButton extends StatefulWidget {
  const BaseButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.minWidth,
    this.leftIcon,
    this.rightIcon,
    this.badgeLabel,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.defaultButton,
    this.borderRadius = const BorderRadius.all(borderRadius100),
  }) : super(key: key);

  final VoidCallback? onPressed;

  final Widget child;

  final double? minWidth;

  final IconData? leftIcon;

  final IconData? rightIcon;

  final String? badgeLabel;

  final OptimusWidgetSize size;

  final OptimusButtonVariant variant;

  final BorderRadius borderRadius;

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> with ThemeGetter {
  bool _isPressed = false;

  Widget _buildIcon(IconData icon) =>
      Icon(icon, size: _iconSize, color: _textColor);

  TextStyle get _textStyle =>
      widget.size == OptimusWidgetSize.small ? preset200b : preset300b;

  Widget _buildBadgeLabel(String badgeLabel) => SizedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(borderRadius200),
          child: Container(
            height: 16,
            color: _textColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing50),
              child: Text(
                badgeLabel,
                style: preset100s.copyWith(
                  color: _badgeTextColor,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
      );

  double get _iconSize {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return 16;
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return 24;
    }
  }

  Color get _color {
    switch (widget.variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.isDark ? theme.colors.neutral400 : theme.colors.neutral50;
      case OptimusButtonVariant.primary:
        return theme.isDark ? theme.colors.primary700 : theme.colors.primary500;
      case OptimusButtonVariant.text:
        return Colors.transparent;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger500;
      case OptimusButtonVariant.warning:
        return theme.colors.warning500;
    }
  }

  Color get _badgeTextColor {
    switch (widget.variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.colors.neutral0;
      case OptimusButtonVariant.primary:
        return theme.colors.primary500;
      case OptimusButtonVariant.text:
        return theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger500;
      case OptimusButtonVariant.warning:
        return theme.colors.warning500;
    }
  }

  Color get _hoverColor {
    switch (widget.variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.isDark ? theme.colors.neutral300 : theme.colors.neutral100;
      case OptimusButtonVariant.primary:
        return theme.isDark ? theme.colors.primary400 : theme.colors.primary700;
      case OptimusButtonVariant.text:
        return theme.colors.neutral500t8;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger700;
      case OptimusButtonVariant.warning:
        return theme.colors.warning700;
    }
  }

  Color get _highLightColor {
    switch (widget.variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.colors.neutral200;
      case OptimusButtonVariant.primary:
        return theme.isDark ? theme.colors.primary500 : theme.colors.primary900;
      case OptimusButtonVariant.text:
        return theme.colors.neutral500t16;
      case OptimusButtonVariant.destructive:
        return theme.colors.danger900;
      case OptimusButtonVariant.warning:
        return theme.colors.warning800;
    }
  }

  Color get _textColor {
    switch (widget.variant) {
      case OptimusButtonVariant.defaultButton:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500;
      case OptimusButtonVariant.primary:
        return theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0;
      case OptimusButtonVariant.text:
        // TODO(V): can be changed when final dark theme design is ready.
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500;
      case OptimusButtonVariant.destructive:
        return theme.colors.neutral0;
      case OptimusButtonVariant.warning:
        return _isPressed ? theme.colors.neutral0 : theme.colors.neutral900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftIcon = widget.leftIcon;
    final rightIcon = widget.rightIcon;
    final badgeLabel = widget.badgeLabel;

    return OptimusEnabled(
      isEnabled: widget.onPressed != null,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: MaterialButton(
          minWidth: widget.minWidth,
          height: widget.size.value,
          visualDensity: VisualDensity.standard,
          elevation: 0,
          highlightElevation: 0,
          highlightColor: _highLightColor,
          disabledColor: _color,
          disabledTextColor: _textColor,
          hoverElevation: 0,
          splashColor: Colors.transparent,
          hoverColor: _hoverColor,
          onPressed: widget.onPressed,
          animationDuration: buttonAnimationDuration,
          shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
          color: _color,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (leftIcon != null) _buildIcon(leftIcon),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacing100),
                child: DefaultTextStyle.merge(
                  child: widget.child,
                  style: _textStyle.copyWith(color: _textColor),
                ),
              ),
              if (badgeLabel != null && badgeLabel.isNotEmpty)
                _buildBadgeLabel(badgeLabel),
              if (rightIcon != null) _buildIcon(rightIcon),
            ],
          ),
        ),
      ),
    );
  }
}
