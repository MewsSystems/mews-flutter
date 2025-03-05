import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default Style',
  type: OptimusCheckbox,
  path: '[Forms]/Checkbox',
)
CheckboxStory defaultStyle(_) => const CheckboxStory();

class CheckboxStory extends StatefulWidget {
  const CheckboxStory({super.key});

  @override
  CheckboxStoryState createState() => CheckboxStoryState();
}

class CheckboxStoryState extends State<CheckboxStory> {
  bool _isChecked = false;

  void _handleChanged(bool isChecked) => setState(() => _isChecked = isChecked);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

    return OptimusCheckbox(
      label: Text(k.string(label: 'Label', initialValue: 'Checkbox Label')),
      error: k.string(label: 'Error'),
      isEnabled: k.isEnabledKnob,
      size: k.list(
        label: 'Size',
        options: OptimusCheckboxSize.values,
        labelBuilder: enumLabelBuilder,
      ),
      isChecked: _isChecked,
      onChanged: _handleChanged,
    );
  }
}
