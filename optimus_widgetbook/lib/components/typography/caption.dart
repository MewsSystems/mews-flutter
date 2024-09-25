import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Caption',
  type: OptimusCaption,
  path: '[Typography]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final variation = k.list(
    label: 'Variation',
    initialOption: Variation.variationNormal,
    options: Variation.values,
  );

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    initialOption: null,
  );

  return OptimusCaption(
    variation: variation,
    align: align,
    child: Text(
      k.string(label: 'Caption', initialValue: 'Caption'),
    ),
  );
}
