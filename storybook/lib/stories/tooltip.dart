import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tooltipStory = Story(
  name: 'Data Display/Tooltip',
  builder: (BuildContext context) {
    final knobs = context.knobs;

    final text = knobs.text(label: 'Label text:', initial: 'Tooltip text');
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

    return OptimusTooltip(
      content: Text(text),
      size: size,
      tooltipPosition: position,
    );
  },
);
