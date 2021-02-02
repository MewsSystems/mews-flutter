import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story checkbox = Story(
  name: 'Checkbox',
  section: 'Checkbox',
  builder: (_, k) => _CheckboxStory(k),
);

class _CheckboxStory extends StatefulWidget {
  const _CheckboxStory(this.knobs, {Key key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _CheckboxStoryState createState() => _CheckboxStoryState();
}

class _CheckboxStoryState extends State<_CheckboxStory> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;
    return OptimusCheckbox(
      label: Text(k.text('Label', initial: 'Checkbox Label')),
      error: k.text('Error'),
      isEnabled: k.boolean('Enabled', initial: true),
      size: k.options('Size', options: OptimusCheckboxSize.values.toOptions(), initial: OptimusCheckboxSize.large),
      isChecked: _checked,
      onChanged: (b) {
        setState(() {
          _checked = b;
        });
      },
    );
  }
}
