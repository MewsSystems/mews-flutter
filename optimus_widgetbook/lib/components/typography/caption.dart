import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Caption', type: OptimusCaption, path: '[Typography]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final variation = k.object.dropdown(
    label: 'Variation',
    initialOption: Variation.variationNormal,
    options: Variation.values,
    labelBuilder: enumLabelBuilder,
  );

  final align = k.objectOrNull.dropdown(
    label: 'Align',
    options: TextAlign.values,
    labelBuilder: enumOrNullLabelBuilder,
  );

  return OptimusCaption(
    variation: variation,
    align: align,
    child: Text(k.string(label: 'Caption', initialValue: 'Caption')),
  );
}
