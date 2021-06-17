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
        OptimusHighlightMajor(
          child: Text(
            k.text(label: 'Major Highlight', initial: 'Major Highlight'),
          ),
        ),
        OptimusHighlightModerate(
          child: Text(
            k.text(label: 'Moderate Highlight', initial: 'Moderate Highlight'),
          ),
        ),
        OptimusHighlightMinor(
          child: Text(
            k.text(label: 'Minor Highlight', initial: 'Minor Highlight'),
          ),
        ),
      ],
    ),
  ),
);
