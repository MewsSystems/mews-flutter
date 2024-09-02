import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default Style',
  type: OptimusChip,
  path: 'Feedback',
)
OptimusChip defaultChip(BuildContext context) => OptimusChip(
      onRemoved: ignore,
      isEnabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
      hasError: context.knobs.boolean(label: 'Error', initialValue: false),
      child: Text(context.knobs.string(label: 'Text', initialValue: 'Chip')),
    );
