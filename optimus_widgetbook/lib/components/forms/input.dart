import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Input',
  type: OptimusInputField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final leadingIcon = k.listOrNull(
    label: 'Leading Icon',
    description: 'Visual hint about this field',
    initialOption: null,
    options: exampleIcons,
  );
  final prefix = k.string(label: 'Prefix');
  final suffix = k.string(label: 'Suffix');
  final trailingIcon = k.listOrNull(
    label: 'Trailing Icon',
    description: 'Widget with some action for this particular field',
    initialOption: null,
    options: exampleIcons,
  );
  final caption = k.string(label: 'Caption', initialValue: '');
  final captionIcon = k.list(
    label: 'Caption Icon',
    initialOption: OptimusIcons.info,
    options: exampleIcons,
  );
  final helperMessage = k.string(label: 'Helper Message', initialValue: '');
  final error = k.string(label: 'Error', initialValue: '');
  final errorVariant = k.list(
    label: 'Error variant',
    initialOption: OptimusInputErrorVariant.bottomHint,
    options: OptimusInputErrorVariant.values,
  );
  final hasCharsLimit = k.boolean(
    label: 'Limit characters',
    initialValue: true,
  );
  int? maxChars;
  if (hasCharsLimit) {
    maxChars = k.int.slider(
      label: 'Max Characters',
      max: 100,
      min: 1,
      initialValue: 30,
    );
  }
  final minLines =
      k.int.slider(label: 'Min lines', initialValue: 1, min: 1, max: 10);
  final keyboardType = k.listOrNull(
    label: 'Keyboard Type:',
    initialOption: null,
    options: KeyboardType.values,
  );
  final isInlined = k.boolean(label: 'Inline', initialValue: false);
  final enableAutoCollapse =
      k.boolean(label: 'Auto Collapse', initialValue: true);

  final statusBar = k.listOrNull(
    label: 'Status Bar',
    options: OptimusStatusBarState.values,
    initialOption: null,
  );

  return Align(
    alignment: Alignment.center,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
      child: OptimusInputField(
        isEnabled: k.boolean(label: 'Enabled', initialValue: true),
        isRequired: k.boolean(label: 'Required'),
        isPasswordField: k.boolean(label: 'Password'),
        maxCharacters: maxChars,
        minLines: minLines,
        maxLines: minLines,
        keyboardType: keyboardType?.inputType,
        prefix: prefix.isNotEmpty ? Text(prefix) : null,
        suffix: suffix.isNotEmpty ? Text(suffix) : null,
        leading: leadingIcon == null ? null : Icon(leadingIcon),
        trailing: trailingIcon == null ? null : Icon(trailingIcon),
        isClearEnabled: k.boolean(label: 'Clear all', initialValue: false),
        showLoader: k.boolean(label: 'Show loader', initialValue: false),
        errorVariant: errorVariant,
        statusBarState: statusBar,
        size: k.list(
          label: 'Size',
          initialOption: OptimusWidgetSize.large,
          options: OptimusWidgetSize.values,
        ),
        isInlined: isInlined,
        enableAutoCollapse: enableAutoCollapse,
        label: k.string(label: 'Label', initialValue: 'Optimus input field'),
        placeholder: k.string(
          label: 'Placeholder',
          initialValue: 'Put some hint here...',
        ),
        caption: caption.isNotEmpty ? Text(caption) : null,
        captionIcon: captionIcon,
        helperMessage: helperMessage.isNotEmpty ? Text(helperMessage) : null,
        error: error,
      ),
    ),
  );
}

enum KeyboardType {
  text(TextInputType.text),
  multiline(TextInputType.multiline),
  number(TextInputType.number),
  phone(TextInputType.phone),
  datetime(TextInputType.datetime),
  emailAddress(TextInputType.emailAddress),
  url(TextInputType.url);

  const KeyboardType(this.inputType);

  final TextInputType inputType;
}
