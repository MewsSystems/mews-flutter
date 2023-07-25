import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story paragraphStory = Story(
  name: 'Other/Typography/Paragraph',
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

    return Center(
      child: OptimusStack(
        spacing: OptimusStackSpacing.spacing200,
        mainAxisSize: MainAxisSize.min,
        children: [
          OptimusParagraph(
            variation: variation,
            align: align,
            child: Text(k.text(label: 'Paragraph', initial: 'Paragraph')),
          ),
          OptimusParagraphSmall(
            variation: variation,
            align: align,
            child: Text(
              k.text(label: 'Small Paragraph', initial: 'Small Paragraph'),
            ),
          ),
        ],
      ),
    );
  },
);
