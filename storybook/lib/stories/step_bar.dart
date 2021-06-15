import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story stepBarStory = Story(
  name: 'Step Bar',
  builder: (_, k) => SingleChildScrollView(
    child: OptimusStepBar(
      type: k.options(
        label: 'Type',
        initial: OptimusStepBarType.icon,
        options: OptimusStepBarType.values
            .map((e) => Option(describeEnum(e), e))
            .toList(),
      ),
      layout: k.options(
        label: 'Layout',
        initial: Axis.horizontal,
        options: Axis.values.map((e) => Option(describeEnum(e), e)).toList(),
      ),
      items: _items,
      currentItem: k
          .slider(
            label: 'Current',
            initial: 0,
            max: _items.length.toDouble() - 1,
          )
          .toInt(),
      maxItem: k
          .slider(label: 'Max', initial: 2, max: _items.length.toDouble() - 1)
          .toInt(),
    ),
  ),
);

const List<OptimusStepBarItem> _items = [
  OptimusStepBarItem(
    label: Text('Step with long title'),
    description: Text('Some description goes here'),
    icon: OptimusIcons.edit,
  ),
  OptimusStepBarItem(
    label: Text('Step 2'),
    icon: OptimusIcons.connect,
  ),
  OptimusStepBarItem(
    label: Text('Step 3'),
    description: Text('Description'),
    icon: OptimusIcons.delete,
  ),
  OptimusStepBarItem(
    label: Text('Step 4'),
    description: Text('Description'),
    icon: OptimusIcons.magic,
  ),
];
