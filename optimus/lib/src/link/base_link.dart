import 'package:flutter/material.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/link/link_variant.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';
import 'package:optimus/src/theme/theme.dart';

class BaseLink extends StatefulWidget {
  const BaseLink({
    super.key,
    required this.text,
    required this.textStyle,
    this.icon,
    this.onPressed,
    this.overflow,
    this.inherit = false,
    this.strong = false,
    this.variant = OptimusLinkVariant.primary,
  });

  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Widget text;
  final Widget? icon;
  final bool strong;
  final bool inherit;
  final TextOverflow? overflow;
  final OptimusLinkVariant variant;

  @override
  State<BaseLink> createState() => _BaseLinkState();
}

class _BaseLinkState extends State<BaseLink> with ThemeGetter {
  bool _isHovering = false;
  bool _isPressed = false;

  void _handleHoverChange(bool isHovering) =>
      setState(() => _isHovering = isHovering);

  void _handlePressedChange(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  Color get _effectiveColor => widget.inherit ? _inheritedColor : _color;

  Color get _color {
    if (!_isEnabled) return widget.variant.getDisabledColor(tokens);
    if (_isPressed) return widget.variant.getTappedColor(tokens);
    if (_isHovering) return widget.variant.getHoveredColor(tokens);

    return widget.variant.getDefaultColor(tokens);
  }

  Color get _inheritedColor => widget.textStyle?.color ?? _color;

  bool get _isEnabled => widget.onPressed != null;

  TextStyle get _textStyle =>
      widget.textStyle ?? DefaultTextStyle.of(context).style;

  @override
  Widget build(BuildContext context) {
    final icon = widget.icon;

    final text = DefaultTextStyle(
      style: _textStyle.copyWith(
        color: _effectiveColor,
        overflow: widget.overflow,
        fontWeight: widget.strong ? FontWeight.w500 : FontWeight.w400,
        decoration: _isHovering ? null : TextDecoration.underline,
      ),
      child: widget.text,
    );

    final child = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              text,
              Padding(
                padding: EdgeInsets.only(left: tokens.spacing100),
                child: IconTheme(
                  data: IconThemeData(color: _effectiveColor),
                  child: icon,
                ),
              ),
            ],
          )
        : text;

    return OptimusEnabled(
      isEnabled: _isEnabled,
      child: GestureWrapper(
        onHoverChanged: _handleHoverChange,
        onPressedChanged: _handlePressedChange,
        onTap: widget.onPressed,
        child: child,
      ),
    );
  }
}

extension on OptimusLinkVariant {
  Color getDefaultColor(OptimusTokens tokens) => switch (this) {
        OptimusLinkVariant.primary => tokens.textInteractivePrimaryDefault,
        OptimusLinkVariant.basic => tokens.textStaticPrimary,
      };
  Color getHoveredColor(OptimusTokens tokens) => switch (this) {
        OptimusLinkVariant.primary => tokens.textInteractivePrimaryHover,
        OptimusLinkVariant.basic => tokens.textStaticTertiary,
      };
  Color getTappedColor(OptimusTokens tokens) => switch (this) {
        OptimusLinkVariant.primary => tokens.textInteractivePrimaryActive,
        OptimusLinkVariant.basic => tokens.textStaticPrimary,
      };
  Color getDisabledColor(OptimusTokens tokens) => tokens.textDisabled;
}
