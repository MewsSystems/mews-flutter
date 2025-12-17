import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final GlobalKey _key = GlobalKey();

@widgetbook.UseCase(
  name: 'Nested Checkbox Group',
  type: OptimusNestedCheckboxGroup,
  path: '[Forms]/Checkbox',
)
Widget defaultStyle(BuildContext _) => CheckboxGroupExample(key: _key);

class CheckboxGroupExample extends StatefulWidget {
  const CheckboxGroupExample({super.key});

  @override
  CheckboxGroupExampleState createState() => .new();
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
    final isEnabled = k.isEnabledKnob;
    final groupLabel = k.string(label: 'Label');

    return Center(
      child: SizedBox(
        width: 400,
        height: 500,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            OptimusCheckbox(
              label: const Text('Outside Checkbox'),
              semanticLabel: 'Outside Checkbox',
              isChecked: _isRootChecked,
              isEnabled: isEnabled,
              onChanged: _handleRootChanged,
            ),
            OptimusNestedCheckboxGroup(
              parent: const Text('Parent'),
              label: groupLabel,
              semanticLabel: groupLabel,
              error: k.stringOrNull(label: 'Group Error'),
              isEnabled: isEnabled,
              children: _values
                  .mapIndexed(
                    (int index, bool isChecked) => OptimusNestedCheckbox(
                      isChecked: isChecked,
                      label: Text('Checkbox $index'),
                      semanticLabel: 'Checkbox $index',
                      error: index == 2
                          ? k.stringOrNull(label: 'Error Inside')
                          : null,
                      onChanged: (bool isChecked) =>
                          _handleChanged(index, isChecked),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
