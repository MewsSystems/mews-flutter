import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/link/base_link.dart';

/// A link widget that is used to display a link inside the
/// body of text. You can pass a custom [TextStyle] which will be used to render
/// the link. The only thing that will be overwritten is the [FontWeight] and
/// will be set to [FontWeight.w600].
///
/// Links as interactive elements should always be used sparingly and with
/// consideration. Too many can easily clutter a page and make it difficult for
/// the user to understand the hierarchy and structure.
class OptimusInlineLink extends StatelessWidget {
  const OptimusInlineLink({
    Key? key,
    required this.text,
    required this.textStyle,
    this.onPressed,
    this.overflow,
    this.inherit = false,
  }) : super(key: key);

  /// Called when link is tapped.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Controls the link's text
  final Widget text;

  /// Controls if link should inherit parent style
  final bool inherit;

  /// Controls the link's text overflowing
  final TextOverflow? overflow;

  /// Custom text style for the link.
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) => BaseLink(
        text: text,
        textStyle: textStyle.copyWith(fontWeight: FontWeight.w600),
        inherit: inherit,
        onPressed: onPressed,
        overflow: overflow,
      );
}
