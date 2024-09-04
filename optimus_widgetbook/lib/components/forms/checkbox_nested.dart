import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Nested Checkbox Group',
  type: OptimusNestedCheckboxGroup,
  path: '[Forms]/Nested Group',
)
Widget defaultStyle(BuildContext context) {
  return Center();
}
