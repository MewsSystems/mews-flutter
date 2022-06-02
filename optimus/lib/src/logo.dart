import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

/// Design system has two versions of the logo:
/// [OptimusMewsLogoVariant.wordmark] - The normal length version of the logo.
/// It is recommended to use it as the default whenever possible.
/// [OptimusMewsLogoVariant.logomark] - The compact, shortened version of the
/// logo, used whenever available space is limited.
enum OptimusMewsLogoVariant { wordmark, logomark }

/// The logo is defined in 3 sizes:
/// [OptimusMewsLogoSizeVariant.large] - Should be used with caution. For
/// example, in cases when highlighting the brand is required.
/// [OptimusMewsLogoSizeVariant.medium] - This is the system default variant,
/// recommended for use whenever possible.
/// [OptimusMewsLogoSizeVariant.small] - This size variant should be used when
/// there is limited space available.
enum OptimusMewsLogoSizeVariant { large, medium, small }

/// For strong and consistent brand experience, the logo is available only in
/// two color options. Always check contrast ratios to ensure the logo is
/// legible and recognizable.
/// [OptimusMewsLogoColorVariant.black] - Use on white or light gray surfaces.
/// [OptimusMewsLogoColorVariant.white] - Use on dark or colored surfaces.
enum OptimusMewsLogoColorVariant { black, white }

/// The preferred placement of the logo in any product is either in the top left
/// or top center. You should avoid aligning or placing the logo on the right
/// side of the screen unless absolutely necessary.
enum OptimusMewsLogoAlignVariant { topLeft, topCenter, center }

/// OptimusMewsLogo is Mews Logo component with clearly defined margins, size
/// and color options.
/// It is provided for better consistency across all products. No text or visual
/// elements may be placed within 1x(x = logo heigh) of the space around it.
class OptimusMewsLogo extends StatelessWidget {
  const OptimusMewsLogo({
    Key? key,
    OptimusMewsLogoVariant logoVariant = OptimusMewsLogoVariant.logomark,
    OptimusMewsLogoSizeVariant sizeVariant = OptimusMewsLogoSizeVariant.medium,
    OptimusMewsLogoColorVariant colorVariant =
        OptimusMewsLogoColorVariant.black,
    OptimusMewsLogoAlignVariant alignVariant =
        OptimusMewsLogoAlignVariant.topCenter,
  })  : _logoVariant = logoVariant,
        _sizeVariant = sizeVariant,
        _colorVariant = colorVariant,
        _alignVariant = alignVariant,
        super(key: key);

  final OptimusMewsLogoVariant _logoVariant;
  final OptimusMewsLogoSizeVariant _sizeVariant;
  final OptimusMewsLogoColorVariant _colorVariant;
  final OptimusMewsLogoAlignVariant _alignVariant;

  Widget get _iconWidget => _NonSquaredIcon(
        _logoIcon,
        size: _size,
        color: _color,
      );

  IconData get _logoIcon {
    switch (_logoVariant) {
      case OptimusMewsLogoVariant.wordmark:
        return OptimusIcons.mews_logo;
      case OptimusMewsLogoVariant.logomark:
        return OptimusIcons.mews_logo_small;
    }
  }

  double get _size {
    switch (_sizeVariant) {
      case OptimusMewsLogoSizeVariant.large:
        return 24;
      case OptimusMewsLogoSizeVariant.medium:
        return 16;
      case OptimusMewsLogoSizeVariant.small:
        return 8;
    }
  }

  Color get _color {
    switch (_colorVariant) {
      case OptimusMewsLogoColorVariant.black:
        return Colors.black;
      case OptimusMewsLogoColorVariant.white:
        return Colors.white;
    }
  }

  EdgeInsets get _margin {
    switch (_alignVariant) {
      case OptimusMewsLogoAlignVariant.topLeft:
        return EdgeInsets.only(bottom: _size, right: _size);
      case OptimusMewsLogoAlignVariant.topCenter:
        return EdgeInsets.fromLTRB(_size, 0, _size, _size);
      case OptimusMewsLogoAlignVariant.center:
        return EdgeInsets.all(_size);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: _margin,
        child: _iconWidget,
      );
}

/// Copy of Flutter Icon, but it does not limit icon shape to square.
class _NonSquaredIcon extends StatelessWidget {
  const _NonSquaredIcon(
    this.icon, {
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  final IconData icon;

  final double size;

  final Color color;

  @override
  Widget build(BuildContext context) => RichText(
        overflow: TextOverflow.visible,
        text: TextSpan(
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
