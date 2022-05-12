import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// Standalone links are available in two size options to accommodate various
/// environments with different requirements.
enum OptimusLinkSize {
  /// Used when space is limited or to match with smaller text sizes on a page.
  small,

  /// Used when space is not limited or to match with larger text sizes on a
  /// page.
  normal,
}

/// Links are navigational elements that can be used separately as standalone
/// elements or inline as part of larger bodies of text. Links as interactive
/// elements should always be used sparingly and with consideration. Too many
/// can easily clutter a page and make it difficult for the user to understand
/// the hierarchy and structure.
class OptimusStandaloneLink extends StatefulWidget {
  const OptimusStandaloneLink({
    Key? key,
    this.onPressed,
    required this.text,
    this.size = OptimusLinkSize.normal,
    this.color,
    this.overflow,
  }) : super(key: key);

  /// Called when link is tapped.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Controls the link's text
  final String text;

  /// Controls the link's size
  final OptimusLinkSize size;

  /// Controls the link's color
  // TODO(VG): should be changed when design changes are finalized
  final Color? color;

  /// Controls the link's text overflowing
  final TextOverflow? overflow;

  @override
  State<OptimusStandaloneLink> createState() => _OptimusStandaloneLinkState();
}

class _OptimusStandaloneLinkState extends State<OptimusStandaloneLink>
    with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  @override
  Widget build(BuildContext context) => OptimusEnabled(
        isEnabled: widget.onPressed != null,
        child: MouseRegion(
          onEnter: (_) => _onHoverChanged(true),
          onExit: (_) => _onHoverChanged(false),
          child: GestureDetector(
            onTap: widget.onPressed,
            onTapDown: (_) => setState(() => _isTappedDown = true),
            onTapUp: (_) => setState(() => _isTappedDown = false),
            onTapCancel: () => setState(() => _isTappedDown = false),
            child: Text(
              widget.text,
              overflow: widget.overflow,
              style: _linkStyle.copyWith(
                decoration: _isHovering ? null : TextDecoration.underline,
                color: _linkColor,
              ),
            ),
          ),
        ),
      );

  TextStyle get _linkStyle =>
      widget.size == OptimusLinkSize.normal ? preset300b : preset200b;

  Color get _linkColor =>
      widget.color ??
      (_isTappedDown ? theme.colors.primary700 : theme.colors.primary500);
}
