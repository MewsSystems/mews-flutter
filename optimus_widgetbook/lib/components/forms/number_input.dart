import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'NumberInput',
  type: OptimusNumberInput,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const _Content();

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final error = k.stringOrNull(label: 'Error', initialValue: 'Error');
    final label = k.string(label: 'Label', initialValue: 'Number input');
    final placeholder =
        k.string(label: 'Placeholder', initialValue: 'Placeholder');

    return OptimusNumberInput(
      label: label,
      placeholder: placeholder,
      error: error,
      onChanged: ignore,
    );
  }
}
