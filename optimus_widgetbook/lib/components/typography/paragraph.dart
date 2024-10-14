import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Paragraph',
  type: OptimusParagraph,
  path: '[Typography]/Paragraph',
)
Widget createLabel(BuildContext context) {
  final k = context.knobs;
  final variation = k.list(
    label: 'Variation',
    initialOption: Variation.variationNormal,
    options: Variation.values,
    labelBuilder: (value) => value.name,
  );

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    initialOption: null,
    labelBuilder: (value) => value?.name ?? 'Name',
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusParagraph(
    align: align,
    variation: variation,
    child: Text(label),
  );
}

@widgetbook.UseCase(
  name: 'Paragraph Small',
  type: OptimusParagraphSmall,
  path: '[Typography]/Paragraph',
)
Widget createParagraphSmall(BuildContext context) {
  final k = context.knobs;
  final variation = k.list(
    label: 'Variation',
    initialOption: Variation.variationNormal,
    options: Variation.values,
    labelBuilder: (value) => value.name,
  );

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    initialOption: null,
    labelBuilder: (value) => value?.name ?? 'Name',
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusParagraphSmall(
    align: align,
    variation: variation,
    child: Text(label),
  );
}
