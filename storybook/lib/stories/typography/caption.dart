import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story captionStory = Story(
  name: 'General/Typography/Caption',
  builder: (context) {
    final k = context.knobs;
    final variation = k.options(
      label: 'Variation',
      initial: Variation.variationNormal,
      options: variationOptions,
    );

    final align = k.options(
      label: 'Align',
      options: TextAlign.values.toOptions(),
      initial: null,
    );

    return OptimusCaption(
      variation: variation,
      align: align,
      child: Text(
        k.text(label: 'Caption', initial: 'Caption'),
      ),
    );
  },
);
