import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimus/optimus.dart';

/// Mews logo variant.
///
/// Design system has two versions of the logo:
///
/// - [OptimusMewsLogoVariant.wordmark] - The normal length version of the logo.
///   It is recommended to use it as the default whenever possible.
/// - [OptimusMewsLogoVariant.logomark] - The compact, shortened version of the
///   logo, used whenever available space is limited.
enum OptimusMewsLogoVariant { wordmark, logomark }

/// Mews logo size.
///
/// The logo is defined in 3 sizes:
///
/// - [OptimusMewsLogoSizeVariant.large] - Should be used with caution. For
///   example, in cases when highlighting the brand is required.
/// - [OptimusMewsLogoSizeVariant.medium] - This is the system default variant,
///   recommended for use whenever possible.
/// - [OptimusMewsLogoSizeVariant.small] - This size variant should be used when
///   there is limited space available.
enum OptimusMewsLogoSizeVariant { large, medium, small }

/// Mews logo color.
///
/// For strong and consistent brand experience, the logo is available only in
/// two color options. Always check contrast ratios to ensure the logo is
/// legible and recognizable.
///
/// - [OptimusMewsLogoColorVariant.black] - Use on white or light gray surfaces.
/// - [OptimusMewsLogoColorVariant.white] - Use on dark or colored surfaces.
enum OptimusMewsLogoColorVariant { black, white }

/// Mews logo alignment.
///
/// The preferred placement of the logo in any product is either in the top left
/// or top center. You should avoid aligning or placing the logo on the right
/// side of the screen unless absolutely necessary.
enum OptimusMewsLogoAlignVariant { topLeft, topCenter, center }

/// Mews Logo component with clearly defined margins, size and color options.
///
/// It is provided for better consistency across all products. No text or visual
/// elements may be placed within 1x(x = logo heigh) of the space around it.
class OptimusMewsLogo extends StatelessWidget {
  const OptimusMewsLogo({
    super.key,
    this.logoVariant = OptimusMewsLogoVariant.logomark,
    this.sizeVariant = OptimusMewsLogoSizeVariant.medium,
    this.colorVariant = OptimusMewsLogoColorVariant.black,
    this.alignVariant = OptimusMewsLogoAlignVariant.topCenter,
    this.semanticsLabel,
    this.productName,
  });

  final OptimusMewsLogoVariant logoVariant;
  final OptimusMewsLogoSizeVariant sizeVariant;
  final OptimusMewsLogoColorVariant colorVariant;
  final OptimusMewsLogoAlignVariant alignVariant;
  final String? productName;

  /// The semantics label for the logo. Defaults to the 'Mews Logo'.
  /// We suggest using a localized string for better accessibility.
  final String? semanticsLabel;

  double _getSize(OptimusTokens tokens) => switch (sizeVariant) {
    OptimusMewsLogoSizeVariant.large => tokens.sizing300,
    OptimusMewsLogoSizeVariant.medium => tokens.sizing200,
    OptimusMewsLogoSizeVariant.small => tokens.sizing100,
  };

  double _getPadding(OptimusTokens tokens) => switch (sizeVariant) {
    OptimusMewsLogoSizeVariant.large => tokens.spacing300,
    OptimusMewsLogoSizeVariant.medium => tokens.spacing200,
    OptimusMewsLogoSizeVariant.small => tokens.spacing100,
  };

  EdgeInsets _getMargin(OptimusTokens tokens) {
    final padding = _getPadding(tokens);

    return switch (alignVariant) {
      OptimusMewsLogoAlignVariant.topLeft => EdgeInsets.only(
        bottom: padding,
        right: padding,
      ),
      OptimusMewsLogoAlignVariant.topCenter => EdgeInsets.fromLTRB(
        padding,
        0,
        padding,
        padding,
      ),
      OptimusMewsLogoAlignVariant.center => EdgeInsets.all(padding),
    };
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final productName = this.productName;

    final logo = switch (logoVariant) {
      OptimusMewsLogoVariant.logomark => _NonSquaredIcon(
        OptimusIcons.mews_logo,
        size: _getSize(tokens),
        color: colorVariant.getColor(tokens),
      ),
      OptimusMewsLogoVariant.wordmark => SizedBox(
        width: _getSize(tokens) * _logoAspectRatio,
        height: _getSize(tokens),
        child: SvgPicture.asset(
          _logoPath,
          package: _packageName,
          colorFilter: ColorFilter.mode(
            colorVariant.getColor(tokens),
            BlendMode.srcIn,
          ),
        ),
      ),
    };

    return Semantics(
      label: semanticsLabel ?? 'Mews Logo',
      child:
          productName != null
              ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  logo,
                  const SizedBox(
                    width: 10,
                  ), // TODO(witwash): replace with tokens
                  _ProductBadge(productName, colorVariant),
                ],
              )
              : logo,
    );
  }
}

class _ProductBadge extends StatelessWidget {
  const _ProductBadge(this.name, this.colorVariant);

  final String name;
  final OptimusMewsLogoColorVariant colorVariant;
  // TODO(witwash): add sizes

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 20, // TODO(witwash): add token
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          // TODO(witwash): fix vertical alignment
          width: context.tokens.borderWidth150,
          color: colorVariant.getColor(context.tokens),
        ),
        borderRadius: BorderRadius.all(context.tokens.borderRadius100),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.tokens.spacing100),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 16, // TODO(witwash): add tokens
            fontWeight: FontWeight.w600,
            color: colorVariant.getColor(context.tokens),
          ),
          child: Text(name),
        ),
      ),
    ),
  );
}

// Copy of Flutter Icon, but it does not limit icon shape to square.
class _NonSquaredIcon extends StatelessWidget {
  const _NonSquaredIcon(this.icon, {required this.size, required this.color});

  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Text.rich(
    overflow: TextOverflow.visible,
    TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        inherit: false,
        color: color,
        fontSize: size,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
    ),
  );
}

extension on OptimusMewsLogoColorVariant {
  Color getColor(OptimusTokens tokens) => switch (this) {
    OptimusMewsLogoColorVariant.black => tokens.backgroundBrand,
    OptimusMewsLogoColorVariant.white => Colors.white,
  };
}

const _packageName = 'optimus';
const _logoPath = 'assets/mews_logo.svg';
const _logoAspectRatio = 7.958;
