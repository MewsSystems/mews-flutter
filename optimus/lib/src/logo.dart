import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

enum OptimusMewsLogoVariant { wordmark, logomark }

enum OptimusMewsLogoSizeVariant { large, medium, small }

enum OptimusMewsLogoColorVariant { black, white }

enum OptimusMewsLogoAlignVariant { topLeft, topCenter, center }

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

  Widget get _icon {
    switch (_logoVariant) {
      case OptimusMewsLogoVariant.wordmark:
        return _NonSquaredIcon(
          OptimusIcons.mews_logo,
          size: _size,
          color: _color,
        );
      case OptimusMewsLogoVariant.logomark:
        return _NonSquaredIcon(
          OptimusIcons.mews_logo_small,
          size: _size,
          color: _color,
        );
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
  Widget build(BuildContext context) =>
      Container(margin: _margin, child: _icon);
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
