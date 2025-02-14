import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
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
    final error = k.stringOrNull(label: 'Error');
    final label = k.string(label: 'Label', initialValue: 'Number input');
    final placeholder =
        k.string(label: 'Placeholder', initialValue: 'Placeholder');
    final min = k.double.input(label: 'Min', initialValue: 0);
    final max = k.double.input(label: 'Max', initialValue: 12);
    final allowNegative =
        k.boolean(label: 'Allow negative', initialValue: false);

    final helper = k.stringOrNull(label: 'Helper Message');
    final prefix = k.stringOrNull(label: 'Prefix');
    final suffix = k.stringOrNull(label: 'Suffix');

    return OptimusNumberInput(
      label: label,
      placeholder: placeholder,
      error: error,
      onChanged: ignore,
      min: min,
      max: max,
      allowNegate: allowNegative,
      isEnabled: k.isEnabledKnob,
      size: k.widgetSizeKnob,
      helper: helper?.toWidget(),
      isInlined: k.boolean(label: 'Inlined'),
      hasFixedDecimalScale: k.boolean(label: 'Has fixed decimal scale'),
      isLoading: k.boolean(label: 'Is loading'),
      precision: k.int.slider(label: 'Precision'),
      prefix: prefix?.toWidget(),
      isRequired: k.boolean(label: 'Required'),
      initialValue: k.double.slider(label: 'Initial', max: max, min: min),
      thousandSeparator: k.list(
        label: 'Thousand Separator',
        options: OptimusNumberSeparatorVariant.values,
        labelBuilder: enumLabelBuilder,
        initialOption: OptimusNumberSeparatorVariant.comma,
      ),
      decimalSeparator: k.list(
        label: 'Decimal Separator',
        options: OptimusNumberSeparatorVariant.values,
        labelBuilder: enumLabelBuilder,
        initialOption: OptimusNumberSeparatorVariant.stop,
      ),
      suffix: suffix?.toWidget(),
      step: k.double.slider(label: 'Step', initialValue: 1),
    );
  }
}
