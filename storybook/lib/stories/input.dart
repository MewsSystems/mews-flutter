import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story inputStory = Story(
  name: 'Input',
  builder: (context) {
    final k = context.knobs;
    final leadingIcon = k.options(
      label: 'Leading Icon',
      description: 'Visual hint about this field',
      initial: null,
      options: exampleIcons,
    );
    final prefix = k.text(label: 'Prefix');
    final suffix = k.text(label: 'Suffix');
    final tailingIcon = k.options(
      label: 'Tailing Icon',
      description: 'Widget with some action for this particular field',
      initial: null,
      options: exampleIcons,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusInputField(
        isEnabled: k.boolean(label: 'Enabled', initial: true),
        isRequired: k.boolean(label: 'Required'),
        isPasswordField: k.boolean(label: 'Password'),
        prefix: prefix.isNotEmpty ? Text(prefix) : null,
        suffix: suffix.isNotEmpty ? Text(suffix) : null,
        leadingWidget: leadingIcon == null ? null : Icon(leadingIcon),
        tailingWidget: tailingIcon == null ? null : Icon(tailingIcon),
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
