import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dateInputStory = Story(
  name: 'Forms/Date Input',
  builder: (context) {
    final k = context.knobs;

    final enabled = k.boolean(label: 'Enabled', initial: true);
    final error = k.text(label: 'Error');
    final isClearEnabled = k.boolean(label: 'Clear all', initial: false);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusDateInputFormField(
        label: 'Date',
        initialValue: DateTime.now(),
        error: error.isNotEmpty ? error : null,
        isEnabled: enabled,
        format: DateFormat.yMd(),
        isClearEnabled: isClearEnabled,
        onSubmitted: (_) => {},
      ),
    );
  },
);
