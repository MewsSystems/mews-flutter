import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final textAreaStory = Story(
  name: 'Forms/Text Area',
  builder: (context) {
    final k = context.knobs;

    final label = k.text(label: 'Label', initial: 'Label');
    final placeholder = k.text(label: 'Placeholder', initial: 'Placeholder');
    final error = k.text(label: 'Error', initial: '');
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final isRequired = k.boolean(label: 'Required', initial: false);
    final rows = k.sliderInt(label: 'Rows', initial: 1, min: 1, max: 10);
    final enableAutoCollapse = k.boolean(label: 'Auto collapse', initial: true);
    final enableAutoSize = k.boolean(label: 'Auto size', initial: true);
    final maxCharacters =
        k.sliderInt(label: 'Max characters', initial: 100, min: 0, max: 100);

    return Padding(
      padding: EdgeInsets.all(context.tokens.spacing100),
      child: OptimusTextArea(
        label: label,
        placeholder: placeholder,
        isEnabled: isEnabled,
        isRequired: isRequired,
        rows: rows,
        enableAutoCollapse: enableAutoCollapse,
        enableAutoSize: enableAutoSize,
        error: error.isNotEmpty ? error : null,
        maxCharacters: maxCharacters == 0 ? null : maxCharacters,
      ),
    );
  },
);
