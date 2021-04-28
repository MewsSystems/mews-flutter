import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story subtitleStory = Story(
  section: 'Typography',
  name: 'Subtitle',
  builder: (_, k) => Center(
    child: OptimusSubtitle(
      child: Text(k.text(label: 'Subtitle', initial: 'Subtitle')),
    ),
  ),
);
