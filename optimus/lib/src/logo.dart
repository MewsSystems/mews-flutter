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
    this.colorVariant,
    this.alignVariant = OptimusMewsLogoAlignVariant.topCenter,
    this.semanticsLabel,
    this.productName,
    this.useMargin = true,
  });

  /// The variant of the logo to be displayed.
  final OptimusMewsLogoVariant logoVariant;

  /// The size of the logo to be displayed.
  final OptimusMewsLogoSizeVariant sizeVariant;

  /// The color variant of the logo. If null, will use an appropriate color
  /// based on the system color.
  final OptimusMewsLogoColorVariant? colorVariant;

  /// The alignment of the logo.
  final OptimusMewsLogoAlignVariant alignVariant;

  /// The name of the product to be displayed next to the logo.
  final String? productName;

  /// The semantics label for the logo. Defaults to the 'Mews Logo'.
  /// We suggest using a localized string for better accessibility.
  final String? semanticsLabel;

  /// Whether to use margin around the logo.
  final bool useMargin;

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
    final colorVariant = this.colorVariant ?? context.fallbackColor;

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

    return MergeSemantics(
      child: Padding(
        padding: useMargin ? _getMargin(tokens) : EdgeInsetsGeometry.zero,
        child: productName != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Semantics(label: semanticsLabel ?? 'Mews Logo', child: logo),
                  SizedBox(width: sizeVariant.getProductPadding(tokens)),
                  _ProductBadge(
                    name: productName,
                    colorVariant: colorVariant,
                    sizeVariant: sizeVariant,
                  ),
                ],
              )
            : logo,
      ),
    );
  }
}

class _ProductBadge extends StatelessWidget {
  // TODO(witwash): could be a reason for a refactor of BaseBadge and replace with it
  const _ProductBadge({
    required this.name,
    required this.colorVariant,
    required this.sizeVariant,
  });

  final String name;
  final OptimusMewsLogoColorVariant colorVariant;
  final OptimusMewsLogoSizeVariant sizeVariant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return name.isNotEmpty
        ? SizedBox(
            height: sizeVariant.getHeight(tokens),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  width: sizeVariant.getBorderWidth(tokens),
                  color: colorVariant.getColor(tokens),
                ),
                borderRadius: BorderRadius.all(tokens.borderRadius150),
              ),

              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  sizeVariant.getHorizontalPadding(tokens),
                  sizeVariant.getVerticalPadding(tokens),
                  sizeVariant.getHorizontalPadding(tokens),
                  0,
                ),
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    fontSize: sizeVariant.fontSize,
                    leadingDistribution: TextLeadingDistribution.even,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.w600,

                    height: 1,
                    color: colorVariant.getColor(tokens),
                  ),
                  child: Text(
                    name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
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

extension on BuildContext {
  OptimusMewsLogoColorVariant get fallbackColor => theme.isDark
      ? OptimusMewsLogoColorVariant.white
      : OptimusMewsLogoColorVariant.black;
}

extension on OptimusMewsLogoSizeVariant {
  double getHeight(OptimusTokens tokens) => switch (this) {
    OptimusMewsLogoSizeVariant.large => tokens.sizing400,
    OptimusMewsLogoSizeVariant.medium =>
      20, // TODO(witwash): replace with tokens
    OptimusMewsLogoSizeVariant.small => tokens.sizing150,
  };

  double getVerticalPadding(OptimusTokens tokens) => switch (this) {
    OptimusMewsLogoSizeVariant.large => tokens.spacing100,
    OptimusMewsLogoSizeVariant.medium ||
    OptimusMewsLogoSizeVariant.small => tokens.spacing25,
  };

  double getHorizontalPadding(OptimusTokens tokens) => switch (this) {
    OptimusMewsLogoSizeVariant.large => tokens.spacing150,
    OptimusMewsLogoSizeVariant.medium => tokens.spacing100,
    OptimusMewsLogoSizeVariant.small => tokens.spacing50,
  };

  double get fontSize => switch (this) {
    OptimusMewsLogoSizeVariant.large => 18, // TODO(witwash): add tokens
    OptimusMewsLogoSizeVariant.medium => 14,
    OptimusMewsLogoSizeVariant.small => 10,
  };

  double getBorderWidth(OptimusTokens tokens) => switch (this) {
    OptimusMewsLogoSizeVariant.large => tokens.borderWidth200,
    OptimusMewsLogoSizeVariant.medium ||
    OptimusMewsLogoSizeVariant.small => tokens.borderWidth100,
  };

  double getProductPadding(OptimusTokens tokens) => switch (this) {
    OptimusMewsLogoSizeVariant.large => tokens.spacing150,
    OptimusMewsLogoSizeVariant.medium => tokens.spacing100,
    OptimusMewsLogoSizeVariant.small => tokens.spacing50,
  };
}

const _packageName = 'optimus';
const _logoPath = 'assets/mews_logo.svg';
const _logoAspectRatio = 7.958;
