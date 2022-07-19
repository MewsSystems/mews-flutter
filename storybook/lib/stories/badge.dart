import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story badgeStory = Story(
  name: 'Feedback/Badge',
  builder: (context) => OptimusBadge(
    text: context.knobs.text(label: 'Content', initial: 'Info Text'),
  ),
);
