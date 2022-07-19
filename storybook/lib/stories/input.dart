import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story inputStory = Story(
  name: 'Forms/Input',
  builder: (context) {
    final k = context.knobs;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusInputField(
        isEnabled: k.boolean(label: 'Enabled', initial: true),
        isRequired: k.boolean(label: 'Required'),
        isPasswordField: k.boolean(label: 'Password'),
        prefix:
            k.boolean(label: 'Prefix') ? const Icon(OptimusIcons.search) : null,
        suffix:
            k.boolean(label: 'Suffix') ? const Icon(OptimusIcons.lock) : null,
        isClearEnabled: k.boolean(label: 'Clear all', initial: false),
        showLoader: k.boolean(label: 'Show loader', initial: false),
        size: k.options(
          label: 'Size',
          initial: OptimusWidgetSize.large,
          options: sizeOptions,
        ),
        label: k.text(label: 'Label', initial: 'Optimus input field'),
        placeholder:
            k.text(label: 'Placeholder', initial: 'Put some hint here...'),
        caption: Text(k.text(label: 'Caption', initial: '')),
        secondaryCaption: Text(k.text(label: 'Secondary caption', initial: '')),
        error: k.text(label: 'Error', initial: ''),
      ),
    );
  },
);
