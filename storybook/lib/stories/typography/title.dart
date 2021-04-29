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
            k.text(label: 'PageTitle', initial: 'PageTitle'),
          ),
        ),
        OptimusSectionTitle(
          child: Text(
            k.text(label: 'SectionTitle', initial: 'SectionTitle'),
          ),
        ),
        OptimusSubsectionTitle(
          child: Text(
            k.text(label: 'SubsectionTitle', initial: 'SubsectionTitle'),
          ),
        ),
      ],
    ),
  ),
);
