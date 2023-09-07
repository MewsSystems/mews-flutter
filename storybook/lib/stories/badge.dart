import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story badgeStory = Story(
  name: 'Feedback/Badge',
  builder: (context) {
    final knobs = context.knobs;
    final grayBackground =
        knobs.boolean(label: 'Grey background', initial: true);
    final outline = knobs.boolean(label: 'Outline', initial: true);

    return Container(
      width: 600,
      height: 400,
      color: grayBackground ? Colors.grey : null,
      child: Center(
        child: OptimusBadge(
          text: knobs.text(label: 'Content', initial: 'Info Text'),
          outline: outline,
        ),
      ),
    );
  },
);
