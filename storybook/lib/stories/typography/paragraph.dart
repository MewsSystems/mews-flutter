import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story paragraphStory = Story(
  section: 'Typography',
  name: 'Paragraph',
  builder: (_, k) {
    final variation = k.options(
      label: 'Variation',
      initial: Variation.variationDefault,
      options: variationOptions,
    );

    return Center(
      child: OptimusStack(
        spacing: OptimusStackSpacing.spacing200,
        mainAxisSize: MainAxisSize.min,
        children: [
          OptimusParagraph(
            variation: variation,
            child: Text(
              k.text(label: 'Paragraph', initial: 'Paragraph'),
            ),
          ),
          OptimusParagraphSmall(
            variation: variation,
            child: Text(
              k.text(label: 'ParagraphSmall', initial: 'ParagraphSmall'),
            ),
          ),
        ],
      ),
    );
  },
);
