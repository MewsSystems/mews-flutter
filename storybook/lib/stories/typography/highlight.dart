import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story highlightStory = Story(
  section: 'Typography',
  name: 'Highlight',
  builder: (_, k) => Center(
    child: OptimusStack(
      spacing: OptimusStackSpacing.spacing200,
      mainAxisSize: MainAxisSize.min,
      children: [
        OptimusHighlightHigh(
          child: Text(
            k.text(label: 'HighlightHigh', initial: 'HighlightHigh'),
          ),
        ),
        OptimusHighlightMedium(
          child: Text(
            k.text(label: 'HighlightMedium', initial: 'HighlightMedium'),
          ),
        ),
        OptimusHighlightLow(
          child: Text(
            k.text(label: 'HighlightLow', initial: 'HighlightLow'),
          ),
        ),
      ],
    ),
  ),
);
