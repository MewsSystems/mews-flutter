import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story inputStory = Story(
  name: 'Input',
  builder: (_, k) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: OptimusInputField(
      isEnabled: k.boolean('Enabled', initial: true),
      isRequired: k.boolean('Required'),
      isPasswordField: k.boolean('Password'),
      prefix: k.boolean('Prefix') ? const Icon(OptimusIcons.search) : null,
      suffix: k.boolean('Suffix') ? const Icon(OptimusIcons.lock) : null,
      size: k.options('Size', initial: OptimusWidgetSize.large, options: sizeOptions),
      label: k.text('Label', initial: 'Optimus input field'),
      placeholder: k.text('Placeholder', initial: 'Put some hint here...'),
      caption: Text(k.text('Caption', initial: '')),
      secondaryCaption: Text(k.text('Secondary caption', initial: '')),
      error: k.text('Error', initial: ''),
    ),
  ),
);
