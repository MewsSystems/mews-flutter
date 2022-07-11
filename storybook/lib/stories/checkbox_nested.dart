import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story checkboxNestedGroup = Story(
  name: 'Checkbox/Checkbox Nested',
  builder: (context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: _CheckboxGroupStory(context.knobs),
  ),
);

class _CheckboxGroupStory extends StatefulWidget {
  const _CheckboxGroupStory(this.knobs, {Key? key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _CheckboxGroupStoryState createState() => _CheckboxGroupStoryState();
}

class _CheckboxGroupStoryState extends State<_CheckboxGroupStory> {
  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;

    return OptimusNestedCheckboxGroup<int>(
      parent: const Text('Checkbox Group 1'),
      label: k.text(label: 'Label', initial: 'Checkbox Group Label'),
      error: k.text(label: 'Error'),
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      values: const [1, 3],
      items: const [
        OptimusGroupItem(label: Text('Checkbox 1'), value: 0),
        OptimusGroupItem(label: Text('Checkbox 2'), value: 1),
        OptimusGroupItem(label: Text('Checkbox 3'), value: 2),
        OptimusGroupItem(label: Text('Checkbox with long label'), value: 3),
      ],
    );
  }
}
