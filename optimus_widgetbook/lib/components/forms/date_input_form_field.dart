import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Date Input Form Field',
  type: OptimusDateInputFormField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final isClearEnabled = k.boolean(label: 'Clear all', initialValue: false);
  final String format = k.list(
    label: 'Format',
    options: _formats,
    initialOption: _formats.first,
  );

  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: OptimusDateInputFormField(
      label: 'Date',
      value: DateTime.now(),
      isEnabled: k.isEnabledKnob,
      format: DateFormat(format),
      isClearAllEnabled: isClearEnabled,
    ),
  );
}

const List<String> _formats = [
  'dd.MM.yyyy',
  'MM/dd/yyyy',
  'dd/MM/yyyy, HH:mm',
];
