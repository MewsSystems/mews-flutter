import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story titleStory = Story(
  name: 'Other/Typography/Title',
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
          OptimusTitleLarge(
            align: align,
            child: Text(
              k.text(label: 'Large Title', initial: 'Large Title'),
            ),
          ),
          OptimusTitleMedium(
            align: align,
            child: Text(
              k.text(label: 'Medium Title', initial: 'Medium Title'),
            ),
          ),
          OptimusTitleSmall(
            align: align,
            child: Text(
              k.text(label: 'Small Title', initial: 'Small Title'),
            ),
          ),
          OptimusSubtitle(
            align: align,
            child: Text(k.text(label: 'Subtitle', initial: 'Subtitle')),
          ),
        ],
      ),
    );
  },
);
