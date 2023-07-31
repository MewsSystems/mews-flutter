import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final toggleStory = Story(
  name: 'Forms/Toggle',
  builder: (context) {
    final k = context.knobs;
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final useIcons = k.boolean(label: 'Use Icons', initial: true);

    return OptimusToggle(
      offIcon: useIcons ? OptimusIcons.lock : null,
      onIcon: useIcons ? OptimusIcons.unlock : null,
      onChanged: isEnabled ? (value) {} : null,
    );
  },
);
