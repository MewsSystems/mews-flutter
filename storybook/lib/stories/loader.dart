import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story loaderStory = Story(
  name: 'Circle loader',
  builder: (_, k) {
    final size = k.options(
      label: 'Size',
      initial: OptimusCircleLoaderSize.medium,
      options: _sizes,
    );

    final appearance = k.options(
      label: 'Appearance',
      initial: OptimusCircleLoaderAppearance.normal,
      options: _appearance,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const OptimusSectionTitle(child: Text('Determined')),
        const SizedBox(height: 8),
        OptimusCircleLoader(
          variant: OptimusCircleLoaderVariant.determinate,
          progress: k.slider(label: 'Progress', initial: 25, max: 100),
          size: size,
          appearance: appearance,
        ),
        const SizedBox(height: 24),
        const OptimusSectionTitle(child: Text('Indeterminate')),
        const SizedBox(height: 8),
        OptimusCircleLoader(
          variant: OptimusCircleLoaderVariant.indeterminate,
          size: size,
          appearance: appearance,
        ),
      ],
    );
  },
);

final List<Option<OptimusCircleLoaderSize>> _sizes = OptimusCircleLoaderSize
    .values
    .map((e) => Option(describeEnum(e), e))
    .toList();

final List<Option<OptimusCircleLoaderAppearance>> _appearance =
    OptimusCircleLoaderAppearance.values
        .map((e) => Option(describeEnum(e), e))
        .toList();
