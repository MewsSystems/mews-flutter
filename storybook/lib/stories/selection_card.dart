import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final selectionCardStory = Story(
  name: 'Forms/SelectionCard',
  builder: (context) => const _SelectionCardExample(),
);

class _SelectionCardExample extends StatefulWidget {
  const _SelectionCardExample();

  @override
  State<_SelectionCardExample> createState() => _SelectionCardExampleState();
}

class _SelectionCardExampleState extends State<_SelectionCardExample> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final title = k.text(label: 'Title', initial: 'Title');
    final description = k.text(label: 'Description', initial: 'Description');
    final trailing = k.options(
      label: 'Trailing',
      options: exampleIcons,
      initial: exampleIcons.first,
    );
    final selectorVariant = k.options(
      label: 'Selector variant',
      initial: OptimusSelectionCardSelectionVariant.radio,
      options: OptimusSelectionCardSelectionVariant.values.toOptions(),
    );
    final showSelector = k.boolean(label: 'Show selector', initial: true);
    final isEnabled = k.boolean(label: 'Enabled', initial: true);

    return OptimusSelectionCard(
      title: Text(title),
      description: description.isNotEmpty ? Text(description) : null,
      trailing: trailing != null ? const Icon(OptimusIcons.add) : null,
      isSelected: _isSelected,
      showSelector: showSelector,
      selectionVariant: selectorVariant,
      isEnabled: isEnabled,
      onPressed: () => setState(() => _isSelected = !_isSelected),
    );
  }
}
