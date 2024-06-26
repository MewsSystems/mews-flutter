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
    final limitChars = k.boolean(
      label: 'Limit characters',
      initial: true,
    );
    int? maxChars;
    if (limitChars) {
      maxChars =
          k.sliderInt(label: 'Max Characters', max: 100, min: 1, initial: 30);
    }
    final inline = k.boolean(label: 'Inline', initial: false);
    final autoCollapse = k.boolean(label: 'Auto Collapse', initial: true);

    final statusBar = k.options(
      label: 'Status Bar',
      options: OptimusStatusBarState.values.toOptions().withEmpty(),
      initial: null,
    );

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
        child: OptimusInputField(
          isEnabled: k.boolean(label: 'Enabled', initial: true),
          isRequired: k.boolean(label: 'Required'),
          isPasswordField: k.boolean(label: 'Password'),
          maxCharacters: maxChars,
          prefix: prefix.isNotEmpty ? Text(prefix) : null,
          suffix: suffix.isNotEmpty ? Text(suffix) : null,
          leading: leadingIcon == null ? null : Icon(leadingIcon),
          trailing: trailingIcon == null ? null : Icon(trailingIcon),
          isClearEnabled: k.boolean(label: 'Clear all', initial: false),
          showLoader: k.boolean(label: 'Show loader', initial: false),
          errorVariant: errorVariant,
          statusBarState: statusBar,
          size: k.options(
            label: 'Size',
            initial: OptimusWidgetSize.large,
            options: sizeOptions,
          ),
          inline: inline,
          autoCollapse: autoCollapse,
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
