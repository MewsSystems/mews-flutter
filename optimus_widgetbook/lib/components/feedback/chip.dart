import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Chip', type: OptimusChip, path: '[Feedback]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final text = k.string(label: 'Chip text', initialValue: 'Chip');
  final hasError = k.boolean(label: 'Error', initialValue: false);

  return OptimusChip(
    isEnabled: k.isEnabledKnob,
    onRemoved: ignore,
    hasError: hasError,
    child: Text(text),
  );
}
