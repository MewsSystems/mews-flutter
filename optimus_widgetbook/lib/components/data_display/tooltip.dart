import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Tooltip',
  type: OptimusTooltip,
  path: '[Data Display]',
)
Widget createDefaultStyle(BuildContext context) {
  final knobs = context.knobs;

  final text = knobs.string(label: 'Label text:', initialValue: 'Tooltip text');
  final position = knobs.list(
    label: 'Position',
    initialOption: OptimusTooltipPosition.top,
    options: OptimusTooltipPosition.values,
  );
  final size = knobs.list(
    label: 'Size',
    initialOption: OptimusToolTipSize.small,
    options: OptimusToolTipSize.values,
  );

  return OptimusTooltip(
    content: Text(text),
    size: size,
    tooltipPosition: position,
  );
}
