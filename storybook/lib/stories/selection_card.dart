import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final selectionCardStory = Story(
  name: 'Forms/SelectionCard',
  builder: (context) {
    final k = context.knobs;
    final title = k.text(label: 'Title', initial: 'Title');
    final description = k.text(label: 'Description', initial: 'Description');
    final trailing = k.options(
      label: 'Trailing',
      options: exampleIcons,
      initial: exampleIcons.first,
    );
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final isSelected = k.boolean(label: 'Selected', initial: false);

    return OptimusSelectionCard(
      title: Text(title),
      description: description.isNotEmpty ? Text(description) : null,
      trailing: trailing != null ? const Icon(OptimusIcons.add) : null,
      isSelected: isSelected,
      isEnabled: isEnabled,
    );
  },
);
