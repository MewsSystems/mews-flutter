import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Pictogram',
  type: OptimusPictogram,
  path: '[Media]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return Center(
    child: OptimusPictogram(
      variant: k.list(
        label: 'Variant',
        options: OptimusPictogramVariant.values,
        labelBuilder: enumLabelBuilder,
      ),
      size: k.list(
        label: 'Size',
        options: OptimusPictogramSize.values,
        initialOption: OptimusPictogramSize.medium,
        labelBuilder: enumLabelBuilder,
      ),
    ),
  );
}
