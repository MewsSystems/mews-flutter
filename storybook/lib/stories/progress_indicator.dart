import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story progressIndicatorStory = Story(
  name: 'Navigation/Progress Indicator',
  builder: (context) {
    final k = context.knobs;

    final layout = k.options(
      label: 'Layout',
      initial: Axis.vertical,
      options: Axis.values.toOptions(),
    );

    const width = 400.0;
    final height = layout == Axis.horizontal ? 100.0 : null;

    return SizedBox(
      width: width,
      height: height,
      child: OptimusProgressIndicator(
        layout: layout,
        items: _items,
        currentItem: k.sliderInt(
          label: 'Current',
          initial: 0,
          max: _items.length - 1,
        ),
        maxItem: k.sliderInt(label: 'Max', initial: 2, max: _items.length - 1),
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
