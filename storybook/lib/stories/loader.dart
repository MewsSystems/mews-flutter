import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story loaderStory = Story(
  name: 'Circle loader',
  builder: (context) {
    final k = context.knobs;
    final size = k.options(
      label: 'Size',
      initial: OptimusCircleLoaderSize.medium,
      options: OptimusCircleLoaderSize.values.toOptions(),
    );

    final appearance = k.options(
      label: 'Appearance',
      initial: OptimusCircleLoaderAppearance.normal,
      options: OptimusCircleLoaderAppearance.values.toOptions(),
    );

    final progress = k.slider(label: 'Progress', initial: 25, max: 100);

    return OptimusStack(
      spacing: OptimusStackSpacing.spacing100,
      mainAxisSize: MainAxisSize.min,
      children: [
        const OptimusSectionTitle(child: Text('Determinate')),
        OptimusCircleLoader(
          variant: OptimusCircleLoaderVariant.determinate(progress),
          size: size,
          appearance: appearance,
        ),
        const SizedBox(height: 24),
        const OptimusSectionTitle(child: Text('Indeterminate')),
        OptimusCircleLoader(
          variant: const OptimusCircleLoaderVariant.indeterminate(),
          size: size,
          appearance: appearance,
        ),
      ],
    );
  },
);
