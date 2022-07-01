import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story inputStory = Story(
  name: 'Input',
  builder: (context) {
    final k = context.knobs;
    final indicativeIcon = k.options(
      label: 'Indicative Icon',
      initial: null,
      options: exampleIcons,
    );
    final prefix = k.text(label: 'Prefix');
    final suffix = k.text(label: 'Suffix');
    final interactiveIcon = k.options(
      label: 'Interactive Icon',
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
        leadingWidget: Icon(indicativeIcon),
        tailingWidget: Icon(interactiveIcon),
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
