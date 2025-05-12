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
  final isEnabled = k.isEnabledKnob;
  final size = k.widgetSizeKnob;
  final error = k.stringOrNull(label: 'Error');

  return OptimusStepperFormField(
    enabled: isEnabled,
    size: size,
    onChanged: ignore,
    initialValue: 8,
    min: 5,
    max: 15,
    validationError: error,
  );
}
