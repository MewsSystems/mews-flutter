import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Toggle',
  type: OptimusToggle,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const _ToggleStory();

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
    final isEnabled = k.isEnabledKnob;
    final useIcons = k.boolean(label: 'Use Icons', initialValue: true);

    return OptimusToggle(
      offIcon: useIcons ? OptimusIcons.lock : null,
      onIcon: useIcons ? OptimusIcons.unlock : null,
      isChecked: _isChecked,
      onChanged: isEnabled ? _handleChanged : null,
    );
  }
}
