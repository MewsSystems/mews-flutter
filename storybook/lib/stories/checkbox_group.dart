import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story checkboxGroup = Story(
  name: 'Checkbox Group',
  section: 'Checkbox',
  builder: (_, k) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: _CheckboxGroupStory(k),
  ),
);

class _CheckboxGroupStory extends StatefulWidget {
  const _CheckboxGroupStory(this.knobs, {Key? key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _CheckboxGroupStoryState createState() => _CheckboxGroupStoryState();
}

class _CheckboxGroupStoryState extends State<_CheckboxGroupStory> {
  Iterable<int> _checks = [1, 3];

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;
    return OptimusCheckboxGroup<int>(
      label: k.text(label: 'Label', initial: 'Checkbox Group Label'),
      error: k.text(label: 'Error'),
      onChanged: (values) => setState(() => _checks = values),
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      values: _checks,
      items: const [
        OptimusGroupItem(label: Text('Checkbox 1'), value: 0),
        OptimusGroupItem(label: Text('Checkbox 2'), value: 1),
        OptimusGroupItem(label: Text('Checkbox 3'), value: 2),
        OptimusGroupItem(label: Text('Checkbox with long label'), value: 3),
      ],
    );
  }
}
