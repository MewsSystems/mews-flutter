import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story button = Story(
  name: 'Buttons/Button',
  builder: (context) {
    final k = context.knobs;

    final icon = k.options(
      label: 'Icon',
      initial: null,
      options: exampleIcons,
    );

    final iconPosition = k.options(
      label: 'Icon position',
      initial: OptimusButtonIconPosition.left,
      options: const [
        Option(label: 'Left', value: OptimusButtonIconPosition.left),
        Option(label: 'Right', value: OptimusButtonIconPosition.right),
      ],
    );

    return SingleChildScrollView(
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
                  icon: icon,
                  iconPosition: iconPosition,
                  badgeLabel: k.text(label: 'Badge', initial: ''),
                  child: Text(k.text(label: 'Text', initial: 'Button')),
                ),
              ),
            )
            .toList(),
      ),
    );
  },
);
