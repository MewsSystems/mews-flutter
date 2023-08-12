import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story inputStory = Story(
  name: 'Forms/Input',
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
    final trailingIcon = k.options(
      label: 'Trailing Icon',
      description: 'Widget with some action for this particular field',
      initial: null,
      options: exampleIcons,
    );
    final caption = k.text(label: 'Caption', initial: '');
    final captionIcon = k.options(
      label: 'Caption Icon',
      initial: OptimusIcons.info,
      options: exampleIcons.withEmpty(),
    );
    final helperMessage = k.text(label: 'Helper Message', initial: '');
    final error = k.text(label: 'Error', initial: '');
    final errorVariant = k.options(
      label: 'Error variant',
      initial: OptimusInputErrorVariant.bottomHint,
      options: OptimusInputErrorVariant.values.toOptions(),
    );

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 200),
        child: OptimusInputField(
          isEnabled: k.boolean(label: 'Enabled', initial: true),
          isRequired: k.boolean(label: 'Required'),
          isPasswordField: k.boolean(label: 'Password'),
          prefix: prefix.isNotEmpty ? Text(prefix) : null,
          suffix: suffix.isNotEmpty ? Text(suffix) : null,
          leading: leadingIcon == null ? null : Icon(leadingIcon),
          trailing: trailingIcon == null ? null : Icon(trailingIcon),
          isClearEnabled: k.boolean(label: 'Clear all', initial: false),
          showLoader: k.boolean(label: 'Show loader', initial: false),
          errorVariant: errorVariant,
          size: k.options(
            label: 'Size',
            initial: OptimusWidgetSize.large,
            options: sizeOptions,
          ),
          label: k.text(label: 'Label', initial: 'Optimus input field'),
          placeholder:
              k.text(label: 'Placeholder', initial: 'Put some hint here...'),
          caption: caption.isNotEmpty ? Text(caption) : null,
          captionIcon: captionIcon,
          helperMessage: helperMessage.isNotEmpty ? Text(helperMessage) : null,
          error: error,
        ),
      ),
    );
  },
);
