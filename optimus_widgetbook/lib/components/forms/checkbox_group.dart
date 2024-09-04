import 'package:flutter/cupertino.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default Style',
  type: OptimusCheckboxGroup<int>,
  path: '[Forms]/Checkbox/',
)
CheckboxGroupUseCase defaultStyle(_) => const CheckboxGroupUseCase();

class CheckboxGroupUseCase extends StatefulWidget {
  const CheckboxGroupUseCase({super.key});

  @override
  CheckboxGroupUseCaseState createState() => CheckboxGroupUseCaseState();
}

class CheckboxGroupUseCaseState extends State<CheckboxGroupUseCase> {
  Iterable<int> _checks = [1, 3];

  void _handleChanged(Iterable<int> values) => setState(() => _checks = values);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

    return OptimusCheckboxGroup<int>(
      label: k.string(label: 'Label', initialValue: 'Checkbox Group Label'),
      error: k.string(label: 'Error'),
      onChanged: _handleChanged,
      isEnabled: k.boolean(label: 'Enabled', initialValue: true),
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
