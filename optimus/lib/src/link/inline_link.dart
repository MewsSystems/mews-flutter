import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/link/base_link.dart';
import 'package:optimus/src/link/link_variant.dart';

/// A link widget that is used to display a link inside the
/// body of text.
///
/// Links as interactive elements should always be used sparingly and with
/// consideration. Too many can easily clutter a page and make it difficult for
/// the user to understand the hierarchy and structure.
class OptimusInlineLink extends StatelessWidget {
  const OptimusInlineLink({
    super.key,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.overflow,
    this.shouldInherit = false,
    this.useStrong = false,
    this.variant = OptimusLinkVariant.primary,
    this.semanticLabel,
    this.semanticLinkUrl,
  });

  /// Called when link is tapped.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Controls the link's text.
  final Widget text;

  /// Controls if link should inherit parent style.
  final bool shouldInherit;

  /// Controls the link's text overflowing.
  final TextOverflow? overflow;

  /// Custom text style for the link.
  final TextStyle? textStyle;

  /// Defines the weight of the font.
  final bool useStrong;

  /// Link color variant.
  final OptimusLinkVariant variant;

  /// Optional semantic link for accessibility purposes.
  final String? semanticLabel;

  /// Optional semantic link for accessibility purposes.
  final Uri? semanticLinkUrl;

  @override
  Widget build(BuildContext context) => BaseLink(
    text: text,
    textStyle: textStyle,
    shouldInherit: shouldInherit,
    onPressed: onPressed,
    overflow: overflow,
    variant: variant,
    useStrong: useStrong,
    semanticLabel: semanticLabel,
    semanticLinkUrl: semanticLinkUrl,
  );
}
