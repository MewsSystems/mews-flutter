import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Drawer Select Input',
  type: OptimusDrawerSelectInput,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const Center();
