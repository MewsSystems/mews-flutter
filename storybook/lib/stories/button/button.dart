import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story button = Story(
  name: 'Buttons/Button',
  builder: (context) {
    final k = context.knobs;

    final leadingIcon = k.options(
      label: 'Leading icon',
      initial: null,
      options: exampleIcons,
    );
    final trailingIcon = k.options(
      label: 'Trailing icon',
      initial: null,
      options: exampleIcons,
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
                  leadingIcon: leadingIcon,
                  trailingIcon: trailingIcon,
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
