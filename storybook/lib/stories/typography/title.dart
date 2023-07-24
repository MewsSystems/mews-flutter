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
          OptimusPageTitle(
            align: align,
            child: Text(
              k.text(label: 'Page Title', initial: 'Page Title'),
            ),
          ),
          OptimusSectionTitle(
            align: align,
            child: Text(
              k.text(label: 'Section Title', initial: 'Section Title'),
            ),
          ),
          OptimusSubsectionTitle(
            align: align,
            child: Text(
              k.text(label: 'Subsection Title', initial: 'Subsection Title'),
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
