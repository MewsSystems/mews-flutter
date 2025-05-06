import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Stepper',
  type: OptimusStepperFormField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusStepperFormField(
    label: k.string(label: 'Label', initialValue: 'Label'),
    enabled: k.isEnabledKnob,
    size: k.widgetSizeKnob,
    onChanged: ignore,
    initialValue: 8,
    min: k.int.slider(label: 'Min', initialValue: 0, min: 0, max: 15),
    max: k.int.slider(label: 'Max', initialValue: 15, min: 15, max: 20),
    validationError: k.string(
      label: 'Validation error',
      initialValue: 'Validation error',
    ),
  );
}
