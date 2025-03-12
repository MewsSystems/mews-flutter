import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Drawer Select Input',
  type: OptimusDrawerSelectInput,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusDrawerSelectInput(
    label: k.string(label: 'Label'),
    items: const [
      ListDropdownTile<String>(value: '1', title: Text('Option 1')),
      ListDropdownTile<String>(value: '2', title: Text('Option 2')),
      ListDropdownTile<String>(value: '3', title: Text('Option 3')),
    ],
    builder: (value) => value,
    onChanged: ignore,
  );
}
