import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Nested Checkbox Group',
  type: OptimusNestedCheckboxGroup,
  path: '[Forms]/Nested Group',
)
Widget defaultStyle(BuildContext _) => const CheckboxGroupExample();

class CheckboxGroupExample extends StatefulWidget {
  const CheckboxGroupExample({super.key});

  @override
  CheckboxGroupExampleState createState() => CheckboxGroupExampleState();
}

class CheckboxGroupExampleState extends State<CheckboxGroupExample> {
  // ignore: avoid-duplicate-collection-elements, duplicity is intentional
  final List<bool> _values = [false, true, false, false, false];
  bool _isRootChecked = false;

  void _handleChanged(int position, bool isChecked) =>
      setState(() => _values[position] = isChecked);

  void _handleRootChanged(bool isRootChecked) =>
      setState(() => _isRootChecked = isRootChecked);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final isEnabled = k.boolean(label: 'Enabled', initialValue: true);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OptimusCheckbox(
            label: const Text('Outside Checkbox'),
            isChecked: _isRootChecked,
            isEnabled: isEnabled,
            onChanged: _handleRootChanged,
          ),
          OptimusNestedCheckboxGroup(
            parent: const Text('Parent'),
            label: k.string(label: 'Label'),
            error: k.string(label: 'Error'),
            isEnabled: isEnabled,
            children: [
              OptimusNestedCheckbox(
                label: const Text('Checkbox 1'),
                isChecked: _values.first,
                onChanged: (bool isChecked) => _handleChanged(0, isChecked),
              ),
              OptimusNestedCheckbox(
                label: const Text('Checkbox 2'),
                isChecked: _values[1],
                onChanged: (bool isChecked) => _handleChanged(1, isChecked),
              ),
              OptimusNestedCheckbox(
                isChecked: _values[2],
                label: const Text('Checkbox 3'),
                onChanged: (bool isChecked) => _handleChanged(2, isChecked),
              ),
              OptimusNestedCheckbox(
                isChecked: _values[3],
                label: const Text('Checkbox 4'),
                onChanged: (bool isChecked) => _handleChanged(3, isChecked),
              ),
              OptimusNestedCheckbox(
                isChecked: _values.last,
                label: const Text('Checkbox 5'),
                onChanged: (bool isChecked) => _handleChanged(4, isChecked),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
