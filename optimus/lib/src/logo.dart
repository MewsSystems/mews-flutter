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
  });

  final OptimusMewsLogoVariant logoVariant;
  final OptimusMewsLogoSizeVariant sizeVariant;
  final OptimusMewsLogoColorVariant colorVariant;
  final OptimusMewsLogoAlignVariant alignVariant;
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

  Color get _color => switch (colorVariant) {
    OptimusMewsLogoColorVariant.black => Colors.black,
    OptimusMewsLogoColorVariant.white => Colors.white,
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

    return Semantics(
      label: semanticsLabel ?? 'Mews Logo',
      child: Padding(
        padding: _getMargin(tokens),
        child: switch (logoVariant) {
          OptimusMewsLogoVariant.logomark => _NonSquaredIcon(
            OptimusIcons.mews_logo,
            size: _getSize(tokens),
            color: _color,
          ),
          OptimusMewsLogoVariant.wordmark => SizedBox(
            height: _getSize(tokens),
            child: SvgPicture.asset(
              _logoPath,
              package: _packageName,
              colorFilter: ColorFilter.mode(_color, BlendMode.srcIn),
            ),
          ),
        },
      ),
    );
  }
}

/// Copy of Flutter Icon, but it does not limit icon shape to square.
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

const _packageName = 'optimus';
const _logoPath = 'assets/mews_logo.svg';
