import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story titleStory = Story(
  name: 'Typography/Title',
  builder: (context) {
    final k = context.knobs;

    return Center(
      child: OptimusStack(
        spacing: OptimusStackSpacing.spacing200,
        mainAxisSize: MainAxisSize.min,
        children: [
          OptimusPageTitle(
            child: Text(
              k.text(label: 'Page Title', initial: 'Page Title'),
            ),
          ),
          OptimusSectionTitle(
            child: Text(
              k.text(label: 'Section Title', initial: 'Section Title'),
            ),
          ),
          OptimusSubsectionTitle(
            child: Text(
              k.text(label: 'Subsection Title', initial: 'Subsection Title'),
            ),
          ),
          OptimusSubtitle(
            child: Text(k.text(label: 'Subtitle', initial: 'Subtitle')),
          ),
        ],
      ),
    );
  },
);
