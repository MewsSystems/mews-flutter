import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story loaderStory = Story(
  name: 'Circle loader',
  builder: (_, k) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const OptimusSectionTitle(child: Text('Determined')),
      const SizedBox(height: 8),
      OptimusCircleLoader(
        variant: OptimusCircleLoaderVariant.determinate,
        progress: k.slider(label: 'Progress', initial: 25, max: 100),
      ),
      const SizedBox(height: 24),
      const OptimusSectionTitle(child: Text('Indeterminate')),
      const SizedBox(height: 8),
      OptimusCircleLoader(
        variant: OptimusCircleLoaderVariant.indeterminate,
      ),
    ],
  ),
);
