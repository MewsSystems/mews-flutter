import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story compactProgressIndicatorStory = Story(
  name: 'Navigation/Compact Progress Indicator',
  builder: (context) {
    final k = context.knobs;

    final alignment = k.options(
      label: 'Alignment position',
      initial: MainAxisAlignment.center,
      options: [
        const Option(label: 'Start', value: MainAxisAlignment.start),
        const Option(label: 'Center', value: MainAxisAlignment.center),
        const Option(label: 'End', value: MainAxisAlignment.end),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 400,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: alignment,
            children: [
              const OptimusNotification(
                title: Text(
                  'Some content at the same layer, that will be hid behind the dropdown,',
                ),
              ),
              OptimusCompactProgressIndicator(
                items: _items,
                currentItem: k.sliderInt(
                  label: 'Current',
                  initial: 0,
                  max: _items.length - 1,
                ),
                maxItem: k.sliderInt(
                  label: 'Max',
                  initial: 2,
                  max: _items.length - 1,
                ),
              ),
              const OptimusNotification(
                title: Text(
                  'Some content at the same layer, that will be hid behind the dropdown,',
                ),
              ),
            ],
          ),
        ),
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
