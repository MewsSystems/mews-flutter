import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tooltipWrapperStory = Story(
  name: 'Data Display/Tooltip Wrapper',
  builder: (BuildContext context) {
    final knobs = context.knobs;

    final text = knobs.text(
      label: 'Label text:',
      initial: 'Some helpful, but not essential, information',
    );
    final position = knobs.options(
      label: 'Position',
      initial: OptimusTooltipPosition.top,
      options: OptimusTooltipPosition.values.toOptions(),
    );
    final size = knobs.options(
      label: 'Size',
      initial: OptimusToolTipSize.small,
      options: OptimusToolTipSize.values.toOptions(),
    );
    final duration =
        knobs.sliderInt(label: 'Duration', initial: 1, min: 0, max: 5);
    final contentAlign = knobs.options(
      label: 'Alert icon align:',
      description: 'Will replace the input field if set to the center',
      options: alignments,
      initial: Alignment.bottomRight,
    );

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
  },
);
