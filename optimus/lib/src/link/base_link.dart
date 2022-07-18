import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

enum OptimusLinkStyle {
  /// Used when the link is not a part of a larger body of text.
  standalone,

  /// Used when the link is a part of a larger body of text.
  inline,
}

/// Links are navigational elements that can be used separately as standalone
/// elements or inline as part of larger bodies of text. Links as interactive
/// elements should always be used sparingly and with consideration. Too many
/// can easily clutter a page and make it difficult for the user to understand
/// the hierarchy and structure.
class BaseLink extends StatefulWidget {
  const BaseLink({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.color,
    this.icon,
    this.onPressed,
    this.overflow,
    this.inherit = false,
  }) : super(key: key);

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
          ? theme.colors.neutral1000
          : _isTappedDown
              ? theme.colors.primary700
              : theme.colors.primary500);

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
