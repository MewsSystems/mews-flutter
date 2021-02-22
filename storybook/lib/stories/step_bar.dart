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
        initial: OptimusStepBarType.icon,
        options: OptimusStepBarType.values
            .map((e) => Option(describeEnum(e), e))
            .toList(),
      ),
      layout: k.options(
        'Layout',
        initial: Axis.horizontal,
        options: Axis.values.map((e) => Option(describeEnum(e), e)).toList(),
      ),
      items: _items,
      currentItem: k
          .slider('Current', initial: 0, max: _items.length.toDouble() - 1)
          .toInt(),
      maxItem: k
          .slider('Max', initial: 2, max: _items.length.toDouble() - 1)
          .toInt(),
    ),
  ),
);

const List<OptimusStepBarItem> _items = [
  OptimusStepBarItem(
    label: Text('Completed'),
    description: Text('Description'),
    icon: OptimusIcons.edit,
  ),
  OptimusStepBarItem(
    label: Text('Active'),
    description: Text('Description'),
    icon: OptimusIcons.edit,
  ),
  OptimusStepBarItem(
    label: Text('Enabled'),
    description: Text('Description'),
    icon: OptimusIcons.edit,
  ),
  OptimusStepBarItem(
    label: Text('Disabled'),
    description: Text('Description'),
    icon: OptimusIcons.edit,
  ),
];
