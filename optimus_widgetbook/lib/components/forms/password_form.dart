import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Password',
  type: OptimusPasswordFormField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final size = k.widgetSizeKnob;
  final placeholder = k.string(label: 'Placeholder', initialValue: 'Password');
  final label = k.string(label: 'Label', initialValue: 'Password');
  final isEnabled = k.isEnabledKnob;
  final isRequired = k.boolean(label: 'Required', initialValue: false);
  final helpMessage = k.string(
    label: 'Help message',
    initialValue: 'Help message',
  );
  final caption = k.string(label: 'Caption', initialValue: 'Caption');
  final statusBarState = k.list(
    label: 'Status bar state',
    initialOption: OptimusStatusBarState.empty,
    labelBuilder: enumLabelBuilder,
    options: OptimusStatusBarState.values,
  );
  final isClearEnabled = k.boolean(label: 'Clear enabled', initialValue: false);

  final showLoader = k.boolean(label: 'Show loader', initialValue: false);

  final showLeading = k.boolean(label: 'Leading icon', initialValue: false);

  return Center(
    child: SizedBox(
      height: 200,
      width: 300,
      child: OptimusPasswordFormField(
        size: size,
        placeholder: placeholder,
        label: label,
        isEnabled: isEnabled,
        isRequired: isRequired,
        helperMessage: helpMessage.maybeToWidget(),
        caption: caption.maybeToWidget(),
        statusBarState: statusBarState,
        isClearEnabled: isClearEnabled,
        showLoader: showLoader,
        leading: showLeading ? const Icon(OptimusIcons.lock) : null,
      ),
    ),
  );
}
