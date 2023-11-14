import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final toggleStory = Story(
  name: 'Forms/Toggle',
  builder: (context) => const _ToggleStory(),
);

class _ToggleStory extends StatefulWidget {
  const _ToggleStory();

  @override
  State<_ToggleStory> createState() => _ToggleStoryState();
}

class _ToggleStoryState extends State<_ToggleStory> {
  bool _isChecked = false;

  void _handleChanged(bool isChecked) => setState(() => _isChecked = isChecked);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final useIcons = k.boolean(label: 'Use Icons', initial: true);

    return OptimusToggle(
      offIcon: useIcons ? OptimusIcons.lock : null,
      onIcon: useIcons ? OptimusIcons.unlock : null,
      isChecked: _isChecked,
      onChanged: isEnabled ? _handleChanged : null,
    );
  }
}
