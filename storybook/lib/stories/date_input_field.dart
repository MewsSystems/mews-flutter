import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dateInputStory = Story(
  name: 'Forms/Date Input',
  builder: (context) {
    final k = context.knobs;

    final enabled = k.boolean(label: 'Enabled', initial: true);
    final placeholder = k.text(label: 'Placeholder', initial: 'DD/MM/YYYY');
    final separator = k.text(label: 'Separator', initial: '/');
    final error = k.text(label: 'Error', initial: '');
    final isClearEnabled = k.boolean(label: 'Clear all', initial: false);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusDateInputFormField(
        label: 'Date',
        error: error.isNotEmpty ? error : null,
        isEnabled: enabled,
        placeholder: placeholder,
        separator: separator,
        isClearEnabled: isClearEnabled,
        onSaved: (newValue) {},
        validator: (value) {},
      ),
    );
  },
);
