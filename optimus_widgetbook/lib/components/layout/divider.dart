import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Divider',
  type: OptimusDivider,
  path: '[Layout]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final text = k.string(label: 'Divider Text', initialValue: 'Divider Text');
  final direction = k.list(
    label: 'Direction',
    initialOption: Axis.horizontal,
    options: Axis.values,
    labelBuilder: enumLabelBuilder,
  );

  return Center(
    child: Flex(
      direction: direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const OptimusLabel(child: Text('Text before divider')),
        OptimusDivider(
          direction: direction,
          child: text.isNotEmpty ? Text(text) : null,
        ),
        const OptimusLabel(child: Text('Text after divider')),
      ],
    ),
  );
}
