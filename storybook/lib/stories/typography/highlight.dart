import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story highlightStory = Story(
  name: 'General/Typography/Highlight',
  builder: (context) {
    final k = context.knobs;

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
          OptimusHighlightMajor(
            align: align,
            child: Text(
              k.text(label: 'Major Highlight', initial: 'Major Highlight'),
            ),
          ),
          OptimusHighlightModerate(
            align: align,
            child: Text(
              k.text(
                label: 'Moderate Highlight',
                initial: 'Moderate Highlight',
              ),
            ),
          ),
          OptimusHighlightMinor(
            align: align,
            child: Text(
              k.text(label: 'Minor Highlight', initial: 'Minor Highlight'),
            ),
          ),
        ],
      ),
    );
  },
);
