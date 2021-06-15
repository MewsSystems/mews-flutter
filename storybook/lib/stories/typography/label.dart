import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story labelStory = Story(
  section: 'Typography',
  name: 'Label',
  builder: (_, k) {
    final variation = k.options(
      label: 'Variation',
      initial: Variation.variationNormal,
      options: variationOptions,
    );

    return Center(
      child: OptimusStack(
        spacing: OptimusStackSpacing.spacing200,
        mainAxisSize: MainAxisSize.min,
        children: [
          OptimusLabel(
            variation: variation,
            child: Text(k.text(label: 'Label', initial: 'Label')),
          ),
          OptimusLabelSmall(
            variation: variation,
            child: Text(k.text(label: 'Small Label', initial: 'Small Label')),
          ),
        ],
      ),
    );
  },
);
