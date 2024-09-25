import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Badge',
  type: OptimusBadge,
  path: '[Feedback]',
)
Widget createDefaultStyle(BuildContext context) {
  final knobs = context.knobs;
  final useGrayBackground =
      knobs.boolean(label: 'Grey background', initialValue: true);
  final isOutlined = knobs.boolean(label: 'Outline', initialValue: true);
  final variant = knobs.list(
    label: 'Variant',
    initialOption: OptimusBadgeVariant.values.first,
    options: OptimusBadgeVariant.values,
  );

  return Container(
    width: 600,
    height: 400,
    color: useGrayBackground ? Colors.grey : null,
    child: Center(
      child: OptimusBadge(
        text: knobs.string(label: 'Content', initialValue: 'Info Text'),
        variant: variant,
        isOutlined: isOutlined,
      ),
    ),
  );
}
