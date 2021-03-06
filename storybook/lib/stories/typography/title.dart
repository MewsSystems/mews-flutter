import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story titleStory = Story(
  section: 'Typography',
  name: 'Title',
  builder: (_, k) => Center(
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
  ),
);
