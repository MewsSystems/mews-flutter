import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/link/base_link.dart';

/// Standalone links are available in two size options to accommodate various
/// environments with different requirements.
enum OptimusStandaloneLinkSize {
  /// Used when space is limited or to match with smaller text sizes on a page.
  medium,

  /// Used when space is not limited or to match with larger text sizes on a
  /// page.
  large,
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
    this.size,
    this.overflow,
    this.shouldInherit = false,
    this.isExternal = false,
    this.useStrong = false,
    this.variant = OptimusLinkVariant.primary,
  });

  /// Called when link is tapped.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Link text.
  final Widget text;

  /// Controls if link should inherit parent style.
  final bool shouldInherit;

  /// Controls if link is external and icon should be displayed.
  final bool isExternal;

  /// Link's text overflow style.
  final TextOverflow? overflow;

  ///  Weight of the font.
  final bool useStrong;

  /// Link size.
  final OptimusStandaloneLinkSize? size;

  // Link color variant.
  final OptimusLinkVariant variant;

  @override
  Widget build(BuildContext context) => BaseLink(
        text: text,
        textStyle: DefaultTextStyle.of(context).style.copyWith(
              fontSize: size?.getFontSize(context.tokens),
            ),
        shouldInherit: shouldInherit,
        onPressed: onPressed,
        overflow: overflow,
        icon: isExternal
            ? Icon(
                OptimusIcons.external_link,
                size: size?.getFontSize(context.tokens),
              )
            : null,
        variant: variant,
        useStrong: useStrong,
      );
}

extension on OptimusStandaloneLinkSize {
  double getFontSize(OptimusTokens tokens) => switch (this) {
        OptimusStandaloneLinkSize.medium => tokens.fontSize100,
        OptimusStandaloneLinkSize.large => tokens.fontSize200,
      };
}
