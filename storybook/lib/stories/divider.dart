import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dividerStory = Story(
  name: 'Layout/Divider',
  builder: (context) {
    final k = context.knobs;
    final text = k.text(label: 'Divider Text', initial: 'Divider Text');
    final direction = k.options<Axis>(
      label: 'Direction',
      initial: Axis.horizontal,
      options: const [
        Option(label: 'Horizontal', value: Axis.horizontal),
        Option(label: 'Vertical', value: Axis.vertical),
      ],
    );
    final variant = k.options<OptimusDividerVariant>(
      label: 'Variant',
      initial: OptimusDividerVariant.normal,
      options: const [
        Option(label: 'Normal', value: OptimusDividerVariant.normal),
        Option(label: 'Bold', value: OptimusDividerVariant.bold),
      ],
    );

    return Center(
      child: Flex(
        direction:
            direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const OptimusLabel(child: Text('Text before divider')),
          OptimusDivider(
            direction: direction,
            variant: variant,
            child: text.isNotEmpty ? Text(text) : null,
          ),
          const OptimusLabel(child: Text('Text after divider'))
        ],
      ),
    );
  },
);
