import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tagStory = Story(
  name: 'Feedback/Tag',
  builder: (context) {
    final k = context.knobs;

    final outline = k.boolean(label: 'Outlined', initial: false);
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
    final text = k.text(label: 'Text', initial: 'Label');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const OptimusSectionTitle(child: Text('Semantic')),
        Wrap(
          children: OptimusColorOption.values
              .map(
                (c) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: OptimusTag(
                    text: text.isEmpty ? describeEnum(c) : text,
                    leadingIcon: leadingIcon,
                    trailingIcon: trailingIcon,
                    colorOption: c,
                    outline: outline,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        const OptimusSectionTitle(child: Text('Categorical')),
        Wrap(
          children: OptimusCategoricalColorOption.values
              .map(
                (c) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: OptimusCategoricalTag(
                    text: text.isEmpty ? describeEnum(c) : text,
                    leadingIcon: leadingIcon,
                    trailingIcon: trailingIcon,
                    colorOption: c,
                    outline: outline,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  },
);
