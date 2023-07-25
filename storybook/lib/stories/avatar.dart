import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final avatarStory = Story(
  name: 'Media/Avatar',
  builder: (_) => const OptimusStack(
    direction: Axis.horizontal,
    mainAxisSize: MainAxisSize.min,
    spacing: OptimusStackSpacing.spacing100,
    children: [
      OptimusAvatar(title: 'Test'),
      OptimusAvatar(title: 'Test', isIndicatorVisible: true),
      OptimusAvatar(title: 'Test', isSmall: false),
      OptimusAvatar(title: 'Test', isSmall: false, isIndicatorVisible: true),
    ],
  ),
);
