import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class MewsHeader extends StatelessWidget {
  const MewsHeader({super.key});

  @override
  Widget build(BuildContext context) => OptimusTheme(
    child: OptimusMewsLogo(
      logoVariant: OptimusMewsLogoVariant.wordmark,
      sizeVariant: OptimusMewsLogoSizeVariant.large,
      alignVariant: OptimusMewsLogoAlignVariant.center,
      colorVariant:
          OptimusTheme.of(context).isDark
              ? OptimusMewsLogoColorVariant.white
              : OptimusMewsLogoColorVariant.black,
    ),
  );
}
