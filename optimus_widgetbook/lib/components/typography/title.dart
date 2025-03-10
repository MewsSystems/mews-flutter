import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Subtitle',
  type: OptimusSubtitle,
  path: '[Typography]',
)
Widget createLabel(BuildContext context) {
  final k = context.knobs;

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    labelBuilder: enumOrNullLabelBuilder,
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusSubtitle(align: align, child: Text(label));
}

@widgetbook.UseCase(
  name: 'Title Large',
  type: OptimusTitleLarge,
  path: '[Typography]/Title',
)
Widget createTitleLarge(BuildContext context) {
  final k = context.knobs;

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    labelBuilder: enumOrNullLabelBuilder,
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusTitleLarge(align: align, child: Text(label));
}

@widgetbook.UseCase(
  name: 'Title Medium',
  type: OptimusTitleMedium,
  path: '[Typography]/Title',
)
Widget createTitleMedium(BuildContext context) {
  final k = context.knobs;

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    labelBuilder: enumOrNullLabelBuilder,
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusTitleMedium(align: align, child: Text(label));
}

@widgetbook.UseCase(
  name: 'Title Small',
  type: OptimusTitleSmall,
  path: '[Typography]/Title',
)
Widget createTitleSmall(BuildContext context) {
  final k = context.knobs;

  final align = k.listOrNull(
    label: 'Align',
    options: TextAlign.values,
    labelBuilder: enumOrNullLabelBuilder,
  );
  final label = k.string(label: 'Label', initialValue: 'Label');

  return OptimusTitleSmall(align: align, child: Text(label));
}
