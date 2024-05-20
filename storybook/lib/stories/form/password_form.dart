import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final passwordStory = Story(
  name: 'Forms/Password',
  builder: (context) {
    final k = context.knobs;

    final size = k.options(
      label: 'Size',
      initial: OptimusWidgetSize.medium,
      options: OptimusWidgetSize.values.toOptions(),
    );
    final placeholder = k.text(label: 'Placeholder', initial: 'Password');
    final label = k.text(label: 'Label', initial: 'Password');
    final isEnabled = k.boolean(
      label: 'Enabled',
      initial: true,
    );
    final isRequired = k.boolean(
      label: 'Required',
      initial: false,
    );
    final helpMessage = k.text(label: 'Help message', initial: 'Help message');
    final caption = k.text(label: 'Caption', initial: 'Caption');
    final statusBarState = k.options(
      label: 'Status bar state',
      initial: OptimusStatusBarState.empty,
      options: OptimusStatusBarState.values.toOptions(),
    );
    final isClearEnabled = k.boolean(
      label: 'Clear enabled',
      initial: false,
    );

    final showLoader = k.boolean(
      label: 'Show loader',
      initial: false,
    );

    final showLeading = k.boolean(
      label: 'Leading icon',
      initial: false,
    );

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
          helperMessage: helpMessage.isNotEmpty ? Text(helpMessage) : null,
          caption: caption.isNotEmpty ? Text(caption) : null,
          statusBarState: statusBarState,
          isClearEnabled: isClearEnabled,
          showLoader: showLoader,
          leading: showLeading ? const Icon(OptimusIcons.lock) : null,
        ),
      ),
    );
  },
);
