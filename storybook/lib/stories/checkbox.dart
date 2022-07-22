import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story checkbox = Story(
  name: 'Forms/Checkbox/Checkbox',
  builder: (context) => _CheckboxStory(context.knobs),
);

class _CheckboxStory extends StatefulWidget {
  const _CheckboxStory(this.knobs, {Key? key}) : super(key: key);

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
      label: Text(k.text(label: 'Label', initial: 'Checkbox Label')),
      error: k.text(label: 'Error'),
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      size: k.options(
        label: 'Size',
        options: OptimusCheckboxSize.values.toOptions(),
        initial: OptimusCheckboxSize.large,
      ),
      isChecked: _checked,
      onChanged: (b) => setState(() {
        _checked = b;
      }),
    );
  }
}
