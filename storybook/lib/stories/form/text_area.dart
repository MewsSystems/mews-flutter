import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final textAreaStory = Story(
  name: 'Forms/Text Area',
  builder: (context) {
    final k = context.knobs;

    final label = k.text(label: 'Label', initial: 'Label');
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final isRequired = k.boolean(label: 'Required', initial: false);
    final rows = k.sliderInt(label: 'Rows', initial: 1, min: 1, max: 10);
    final autoCollapse = k.boolean(label: 'Auto collapse', initial: true);
    final autoSize = k.boolean(label: 'Auto size', initial: true);

    return Padding(
      padding: EdgeInsets.all(context.tokens.spacing100),
      child: OptimusTextArea(
        label: label,
        isEnabled: isEnabled,
        isRequired: isRequired,
        rows: rows,
        autoCollapse: autoCollapse,
        autoSize: autoSize,
      ),
    );
  },
);
