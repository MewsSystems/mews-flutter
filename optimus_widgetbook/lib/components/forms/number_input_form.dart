import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _numberKey = GlobalKey();

@widgetbook.UseCase(
  name: 'NumberInputForm',
  type: OptimusNumberInputFormField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) =>
    NumberInputFormFieldUserCase(key: _numberKey);

class NumberInputFormFieldUserCase extends StatefulWidget {
  const NumberInputFormFieldUserCase({super.key});

  @override
  State<NumberInputFormFieldUserCase> createState() =>
      NumberInputFormFieldUseCaseState();
}

class NumberInputFormFieldUseCaseState
    extends State<NumberInputFormFieldUserCase> {
  late final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

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
    final isInlined = k.boolean(label: 'Inlined');
    final showLoader = k.boolean(label: 'Show Loader');
    final precision = k.int.slider(label: 'Precision', initialValue: 2);
    final isRequired = k.boolean(label: 'Required');
    final separatorVariant = k.list(
      label: 'Separator Variant',
      options: OptimusNumberSeparatorVariant.values,
      labelBuilder: enumLabelBuilder,
      initialOption: OptimusNumberSeparatorVariant.commaAndStop,
    );
    final step = k.double.input(label: 'Step', initialValue: 1);

    return Center(
      child: SizedBox(
        width: 400,
        height: 200,
        child: OptimusNumberInputFormField(
          label: label,
          placeholder: placeholder,
          controller: _controller,
          min: min,
          max: max,
          allowNegate: allowNegative,
          isEnabled: k.isEnabledKnob,
          size: k.widgetSizeKnob,
          helperMessage: helper?.maybeToWidget(),
          isInlined: isInlined,
          showLoader: showLoader,
          precision: precision,
          prefix: prefix?.maybeToWidget(),
          isRequired: isRequired,
          separatorVariant: separatorVariant,
          suffix: suffix?.maybeToWidget(),
          step: step,
        ),
      ),
    );
  }
}
