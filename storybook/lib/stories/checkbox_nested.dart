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
  const _CheckboxGroupStory(this.knobs);

  final KnobsBuilder knobs;

  @override
  _CheckboxGroupStoryState createState() => _CheckboxGroupStoryState();
}

class _CheckboxGroupStoryState extends State<_CheckboxGroupStory> {
  final List<bool> _values = [false, true, false, false, false];
  bool _outsideCheckbox = false;

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;

    final enabled = k.boolean(label: 'Enabled', initial: true);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OptimusCheckbox(
            label: const Text('Outside Checkbox'),
            isChecked: _outsideCheckbox,
            isEnabled: enabled,
            onChanged: (bool value) {
              setState(() {
                _outsideCheckbox = value;
              });
            },
          ),
          OptimusNestedCheckboxGroup(
            parent: const Text('Parent'),
            label: k.text(label: 'Label'),
            error: k.text(label: 'Error'),
            isEnabled: enabled,
            children: [
              OptimusNestedCheckbox(
                label: const Text('Checkbox 1'),
                isChecked: _values.first,
                onChanged: (bool value) =>
                    setState(() => _values.first = value),
              ),
              OptimusNestedCheckbox(
                label: const Text('Checkbox 2'),
                isChecked: _values[1],
                onChanged: (bool value) => setState(() => _values[1] = value),
              ),
              OptimusNestedCheckbox(
                isChecked: _values[2],
                label: const Text('Checkbox 3'),
                onChanged: (bool value) => setState(() => _values[2] = value),
              ),
              OptimusNestedCheckbox(
                isChecked: _values[3],
                label: const Text('Checkbox 4'),
                onChanged: (bool value) => setState(() => _values[3] = value),
              ),
              OptimusNestedCheckbox(
                isChecked: _values.last,
                label: const Text('Checkbox 5'),
                onChanged: (bool value) => setState(() => _values.last = value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
