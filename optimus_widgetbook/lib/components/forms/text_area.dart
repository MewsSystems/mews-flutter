import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Text Area', type: OptimusTextArea, path: '[Forms]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final label = k.string(label: 'Label', initialValue: 'Label');
  final placeholder = k.string(
    label: 'Placeholder',
    initialValue: 'Placeholder',
  );
  final error = k.string(label: 'Error', initialValue: '');
  final isEnabled = k.isEnabledKnob;
  final isRequired = k.boolean(label: 'Required', initialValue: false);
  final rows = k.int.slider(label: 'Rows', initialValue: 1, min: 1, max: 10);
  final enableAutoCollapse = k.boolean(
    label: 'Auto collapse',
    initialValue: true,
  );
  final enableAutoSize = k.boolean(label: 'Auto size', initialValue: true);
  final maxCharacters = k.int.slider(
    label: 'Max characters',
    initialValue: 100,
    min: 0,
    max: 100,
  );

  return Padding(
    padding: EdgeInsets.all(context.tokens.spacing100),
    child: OptimusTextArea(
      label: label,
      placeholder: placeholder,
      isEnabled: isEnabled,
      isRequired: isRequired,
      rows: rows,
      enableAutoCollapse: enableAutoCollapse,
      enableAutoSize: enableAutoSize,
      error: error.isNotEmpty ? error : null,
      maxCharacters: maxCharacters == 0 ? null : maxCharacters,
    ),
  );
}
