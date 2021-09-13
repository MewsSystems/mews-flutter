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
          .map(
            (v) => Padding(
              padding: const EdgeInsets.all(8),
              child: OptimusButton(
                onPressed:
                    k.boolean(label: 'Enabled', initial: true) ? () {} : null,
                size: k.options(
                  label: 'Size',
                  initial: OptimusWidgetSize.large,
                  options: sizeOptions,
                ),
                variant: v,
                leftIcon: k.options(
                  label: 'Left icon',
                  initial: null,
                  options: exampleIcons,
                ),
                rightIcon: k.options(
                  label: 'Right icon',
                  initial: null,
                  options: exampleIcons,
                ),
                badgeLabel: k.text(label: 'Badge', initial: ''),
                child: Text(k.text(label: 'Text', initial: 'Button')),
              ),
            ),
          )
          .toList(),
    ),
  ),
);
