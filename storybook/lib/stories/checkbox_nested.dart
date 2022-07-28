import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story checkboxNestedGroup = Story(
  name: 'Forms/Checkbox/Checkbox Nested',
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

    return OptimusNestedCheckboxGroup(
      parent: OptimusCheckbox(
        label: const Text('Parent'),
        onChanged: (bool value) {},
      ),
      label: k.text(label: 'Label:'),
      error: k.text(label: 'Error'),
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      children: [
        OptimusCheckbox(
          label: const Text('Checkbox 1'),
          isChecked: true,
          onChanged: (bool value) {},
        ),
        OptimusCheckbox(
          label: const Text('Checkbox 2'),
          onChanged: (bool value) {},
        ),
        OptimusCheckbox(
          label: const Text('Checkbox 3'),
          onChanged: (bool value) {},
        ),
        OptimusCheckbox(
          label: const Text('Checkbox 4'),
          onChanged: (bool value) {},
        ),
        OptimusCheckbox(
          label: const Text('Checkbox 5'),
          onChanged: (bool value) {},
        ),
      ],
    );
  }
}
