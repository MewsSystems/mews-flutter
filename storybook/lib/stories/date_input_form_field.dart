import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dateInputFormFieldStory = Story(
  name: 'Forms/Date Input Form Field',
  builder: (context) {
    final k = context.knobs;

    final enabled = k.boolean(label: 'Enabled', initial: true);
    final isClearEnabled = k.boolean(label: 'Clear all', initial: false);
    final String format = k.options(
      label: 'Format',
      options: _formats,
      initial: _formats.first.value,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusDateInputFormField(
        label: 'Date',
        initialValue: DateTime.now(),
        isEnabled: enabled,
        format: DateFormat(format),
        isClearAllEnabled: isClearEnabled,
      ),
    );
  },
);

const List<Option<String>> _formats = [
  Option(label: 'dd.MM.yyyy', value: 'dd.MM.yyyy'),
  Option(label: 'MM/dd/yyyy', value: 'MM/dd/yyyy'),
  Option(label: 'dd/MM/yyyy, HH:mm', value: 'dd/MM/yyyy, HH:mm'),
];
