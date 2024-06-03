import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story progressIndicatorStory = Story(
  name: 'Navigation/Progress Indicator',
  builder: (context) {
    final k = context.knobs;

    return SingleChildScrollView(
      child: OptimusProgressIndicator(
        layout: k.options(
          label: 'Layout',
          initial: Axis.horizontal,
          options: Axis.values.toOptions(),
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
    );
  },
);

const List<OptimusProgressIndicatorItem> _items = [
  OptimusProgressIndicatorItem(
    label: Text('Step with long title'),
    description: Text('Some description goes here'),
    icon: OptimusIcons.edit,
  ),
  OptimusProgressIndicatorItem(
    label: Text('Step 2'),
    icon: OptimusIcons.connect,
  ),
  OptimusProgressIndicatorItem(
    label: Text('Step 3'),
    description: Text('Description'),
    icon: OptimusIcons.delete,
  ),
  OptimusProgressIndicatorItem(
    label: Text('Step 4'),
    description: Text('Description'),
    icon: OptimusIcons.magic,
  ),
];
