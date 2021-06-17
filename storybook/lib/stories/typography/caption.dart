import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story captionStory = Story(
  section: 'Typography',
  name: 'Caption',
  builder: (_, k) {
    final variation = k.options(
      label: 'Variation',
      initial: Variation.variationNormal,
      options: variationOptions,
    );

    return OptimusCaption(
      variation: variation,
      child: Text(k.text(label: 'Caption', initial: 'Caption')),
    );
  },
);
