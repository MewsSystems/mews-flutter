import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/link/base_link.dart';
import 'package:optimus/src/typography/presets.dart';

/// Standalone links are available in two size options to accommodate various
/// environments with different requirements.
enum OptimusStandaloneLinkSize {
  /// Used when space is limited or to match with smaller text sizes on a page.
  small,

  /// Used when space is not limited or to match with larger text sizes on a
  /// page.
  normal,
}

/// A link widget that is used to display a link on its own, not a part of the
/// body of the text. Can be paired with an icon if it links somewhere external.
///
/// Links as interactive elements should always be used sparingly and with
/// consideration. Too many can easily clutter a page and make it difficult for
/// the user to understand the hierarchy and structure.
class OptimusStandaloneLink extends StatelessWidget {
  const OptimusStandaloneLink({
    super.key,
    this.onPressed,
    required this.text,
    required this.size,
    this.color,
    this.overflow,
    this.inherit = false,
    this.external = false,
  });

  /// Called when link is tapped.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Controls the link's text
  final Widget text;

  /// Controls the link's size
  final OptimusStandaloneLinkSize size;

  /// Controls the link's color
  final Color? color;

  /// Controls if link should inherit parent style
  final bool inherit;

  /// Controls if link is external and icon should be displayed
  final bool external;

  /// Controls the link's text overflowing
  final TextOverflow? overflow;

  Widget? get _icon => external
      ? Icon(
          OptimusIcons.external_link,
          size: size.iconSize,
        )
      : null;

  @override
  Widget build(BuildContext context) => BaseLink(
        text: text,
        textStyle: size.linkStyle,
        color: color,
        inherit: inherit,
        onPressed: onPressed,
        overflow: overflow,
        icon: _icon,
      );
}

extension on OptimusStandaloneLinkSize {
  TextStyle get linkStyle {
    switch (this) {
      case OptimusStandaloneLinkSize.small:
        return preset200b;
      case OptimusStandaloneLinkSize.normal:
        return preset300b;
    }
  }

  double get iconSize {
    switch (this) {
      case OptimusStandaloneLinkSize.small:
        return 14;
      case OptimusStandaloneLinkSize.normal:
        return 16;
    }
  }
}
