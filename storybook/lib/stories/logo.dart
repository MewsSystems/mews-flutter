import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story logoStory = Story(
  name: 'Media/Logo',
  builder: (context) {
    final knobs = context.knobs;
    final variant = knobs.options(
      label: 'Variant',
      initial: OptimusMewsLogoVariant.wordmark,
      options: OptimusMewsLogoVariant.values.toOptions(),
    );
    final size = knobs.options(
      label: 'Size',
      initial: OptimusMewsLogoSizeVariant.medium,
      options: OptimusMewsLogoSizeVariant.values.toOptions(),
    );
    final color = knobs.options(
      label: 'Color',
      initial: OptimusMewsLogoColorVariant.black,
      options: OptimusMewsLogoColorVariant.values.toOptions(),
    );
    final align = knobs.options(
      label: 'Align',
      initial: OptimusMewsLogoAlignVariant.topCenter,
      options: OptimusMewsLogoAlignVariant.values.toOptions(),
    );

    return Container(
      alignment: Alignment.center,
      color: color == OptimusMewsLogoColorVariant.white ? Colors.black : null,
      child: OptimusMewsLogo(
        logoVariant: variant,
        sizeVariant: size,
        colorVariant: color,
        alignVariant: align,
      ),
    );
  },
);
