import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Spinner',
  type: OptimusSpinner,
  path: '[Feedback]',
)
Widget createDefaultStyle(BuildContext context) {
  final size = context.knobs.list(
    label: 'Size',
    initialOption: OptimusSpinnerSize.medium,
    options: OptimusSpinnerSize.values,
  );

  return Center(
    child: OptimusSpinner(size: size),
  );
}
