import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Tooltip Wrapper',
  type: OptimusTooltipWrapper,
  path: '[Data Display]',
)
Widget createDefaultStyle(BuildContext context) {
  final knobs = context.knobs;

  final text = knobs.string(
    label: 'Label text:',
    initialValue: 'Some helpful, but not essential, information',
  );
  final position = knobs.list(
    label: 'Position',
    initialOption: OptimusTooltipPosition.top,
    options: OptimusTooltipPosition.values,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.list(
    label: 'Size',
    initialOption: OptimusToolTipSize.small,
    options: OptimusToolTipSize.values,
    labelBuilder: (value) => value.name,
  );
  final duration =
      knobs.int.slider(label: 'Duration', initialValue: 1, min: 0, max: 5);
  final contentAlign = knobs.alignmentKnob();

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Stack(
      children: [
        Align(
          alignment: contentAlign,
          child: OptimusTooltipWrapper(
            text: Text(text),
            autoHideDuration: Duration(seconds: duration),
            size: size,
            tooltipPosition: position,
            child: const Icon(OptimusIcons.alert_circle),
          ),
        ),
        if (contentAlign != Alignment.center)
          Center(
            child: SizedBox(
              width: 400,
              child: OptimusInputField(
                label: 'Label',
                placeholder: 'Press info icon to show tooltip',
                suffix: OptimusTooltipWrapper(
                  text: Text(text),
                  autoHideDuration: Duration(seconds: duration),
                  size: size,
                  tooltipPosition: position,
                  child: const Icon(OptimusIcons.info),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
