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

class OptimusStandaloneLink extends StatelessWidget {
  const OptimusStandaloneLink({
    Key? key,
    this.onPressed,
    required this.text,
    required this.size,
    this.color,
    this.overflow,
    this.inherit = false,
    this.external = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget text;
  final OptimusStandaloneLinkSize size;
  final Color? color;
  final bool inherit;
  final bool external;
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
