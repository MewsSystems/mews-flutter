import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Label',
  type: OptimusLabel,
  path: '[Typography]/Label',
)
Widget createLabel(BuildContext context) {
  final k = context.knobs;
  final variation = k.list(
    label: 'Variation',
    initialOption: Variation.variationNormal,
    options: Variation.values,
    labelBuilder: enumLabelBuilder,
  );

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    labelBuilder: enumOrNullLabelBuilder,
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusLabel(align: align, variation: variation, child: Text(label));
}

@widgetbook.UseCase(
  name: 'Label Small',
  type: OptimusLabelSmall,
  path: '[Typography]/Label',
)
Widget createSmallLabel(BuildContext context) {
  final k = context.knobs;
  final variation = k.list(
    label: 'Variation',
    initialOption: Variation.variationNormal,
    options: Variation.values,
    labelBuilder: enumLabelBuilder,
  );

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    labelBuilder: enumOrNullLabelBuilder,
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusLabelSmall(
    align: align,
    variation: variation,
    child: Text(label),
  );
}
