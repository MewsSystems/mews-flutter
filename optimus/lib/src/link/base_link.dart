import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class BaseLink extends StatefulWidget {
  const BaseLink({
    super.key,
    required this.text,
    required this.textStyle,
    this.color,
    this.icon,
    this.onPressed,
    this.overflow,
    this.inherit = false,
  });

  final VoidCallback? onPressed;
  final TextStyle textStyle;
  final Widget text;
  final Widget? icon;
  final Color? color;
  final bool inherit;
  final TextOverflow? overflow;

  @override
  State<BaseLink> createState() => _BaseLinkState();
}

class _BaseLinkState extends State<BaseLink> with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  Color get _color =>
      widget.color ??
      (widget.inherit
          ? _inheritedColor
          : _isTappedDown
              ? theme.colors.primary700
              : theme.colors.primary500);

  Color get _inheritedColor =>
      widget.textStyle.color ?? theme.colors.neutral1000;

  @override
  Widget build(BuildContext context) {
    final icon = widget.icon;

    return OptimusEnabled(
      isEnabled: widget.onPressed != null,
      child: MouseRegion(
        onEnter: (_) => _onHoverChanged(true),
        onExit: (_) => _onHoverChanged(false),
        child: GestureDetector(
          onTap: widget.onPressed,
          onTapDown: (_) => setState(() => _isTappedDown = true),
          onTapUp: (_) => setState(() => _isTappedDown = false),
          onTapCancel: () => setState(() => _isTappedDown = false),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: spacing50),
                  child: IconTheme(
                    data: IconThemeData(color: _color),
                    child: icon,
                  ),
                ),
              DefaultTextStyle(
                style: widget.textStyle.copyWith(
                  color: _color,
                  overflow: widget.overflow,
                  decoration: _isHovering ? null : TextDecoration.underline,
                ),
                child: widget.text,
              )
            ],
          ),
        ),
      ),
    );
  }
}
