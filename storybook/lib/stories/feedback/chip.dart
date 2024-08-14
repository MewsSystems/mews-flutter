import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final chipStory = Story(
  name: 'Feedback/Chip',
  builder: (context) {
    final k = context.knobs;

    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final text = k.text(label: 'Chip text', initial: 'Chip');
    final hasError = k.boolean(label: 'Error', initial: false);

    return OptimusChip(
      isEnabled: isEnabled,
      onRemoved: () {},
      hasError: hasError,
      child: Text(text),
    );
  },
);
