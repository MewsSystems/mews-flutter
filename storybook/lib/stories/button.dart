import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story button = Story(
  section: 'Button',
  name: 'Button',
  builder: (_, k) => SingleChildScrollView(
    child: Column(
      children: OptimusButtonVariant.values
          .map((v) => Padding(
                padding: const EdgeInsets.all(8),
                child: OptimusButton(
                  onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
                  size: k.options(
                    'Size',
                    initial: OptimusWidgetSize.large,
                    options: sizeOptions,
                  ),
                  variant: v,
                  leftIcon: k.options(
                    'Left icon',
                    initial: null,
                    options: exampleIcons,
                  ),
                  rightIcon: k.options(
                    'Right icon',
                    initial: null,
                    options: exampleIcons,
                  ),
                  badgeLabel: k.text('Badge', initial: null),
                  child: Text(k.text('Text', initial: 'Button')),
                ),
              ))
          .toList(),
    ),
  ),
);
