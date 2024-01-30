import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story highlightStory = Story(
  name: 'Other/Typography/Highlight',
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
          OptimusHighlightLarge(
            align: align,
            child: Text(
              k.text(label: 'Large Highlight', initial: 'Large Highlight'),
            ),
          ),
          OptimusHighlightMedium(
            align: align,
            child: Text(
              k.text(
                label: 'Medium Highlight',
                initial: 'Medium Highlight',
              ),
            ),
          ),
          OptimusHighlightSmall(
            align: align,
            child: Text(
              k.text(label: 'Small Highlight', initial: 'Small Highlight'),
            ),
          ),
        ],
      ),
    );
  },
);
