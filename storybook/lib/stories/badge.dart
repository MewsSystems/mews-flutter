import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story badgeStory = Story(
  name: 'Badge',
  builder: (_, k) => OptimusBadge(
    text: k.text(label: 'Content', initial: 'Info Text'),
  ),
);
