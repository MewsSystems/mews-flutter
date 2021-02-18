import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

// TODO(MM): knobs
final Story stepBarStory = Story(
  name: 'Step Bar',
  builder: (_, k) => const SingleChildScrollView(
    child: OptimusStepBar(
      type: StepBarType.icon,
      layout: Axis.horizontal,
      items: _items,
    ),
  ),
);

const List<StepBarItem> _items = [
  StepBarItem(
    label: Text('Label 1'),
    description: Text('Description'),
    icon: OptimusIcons.magic,
  ),
  StepBarItem(
    label: Text('Label 2'),
    description: Text('Description'),
    icon: OptimusIcons.mews_logo,
  ),
  StepBarItem(
    label: Text('Label 3'),
    description: Text('Description'),
    icon: OptimusIcons.edit,
  ),
];
