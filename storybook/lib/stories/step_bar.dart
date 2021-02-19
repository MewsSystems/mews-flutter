import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

// TODO(MM): knobs
final Story stepBarStory = Story(
  name: 'Step Bar',
  builder: (_, k) => SingleChildScrollView(
    child: OptimusStepBar(
      type: k.options(
        'Type',
        initial: StepBarType.icon,
        options:
            StepBarType.values.map((e) => Option(describeEnum(e), e)).toList(),
      ),
      layout: k.options(
        'Layout',
        initial: Axis.horizontal,
        options: Axis.values.map((e) => Option(describeEnum(e), e)).toList(),
      ),
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
