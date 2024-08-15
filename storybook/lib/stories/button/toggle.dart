import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final toggleButtonStory = Story(
  name: 'Buttons/Toggle',
  builder: (context) {
    final k = context.knobs;
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final size = k.options(
      label: 'Size',
      initial: OptimusToggleButtonSizeVariant.large,
      options: OptimusToggleButtonSizeVariant.values.toOptions(),
    );
    final hasLabel = k.boolean(label: 'Label', initial: true);

    return Center(
      child:
          _ToggleExample(hasLabel: hasLabel, isEnabled: isEnabled, size: size),
    );
  },
);

class _ToggleExample extends StatefulWidget {
  const _ToggleExample({
    required this.hasLabel,
    required this.isEnabled,
    required this.size,
  });

  final bool hasLabel;
  final bool isEnabled;
  final OptimusToggleButtonSizeVariant size;

  @override
  State<_ToggleExample> createState() => _ToggleExampleState();
}

class _ToggleExampleState extends State<_ToggleExample> {
  bool _isToggled = false;
  bool _isLoading = false;
  String _label = 'Claim';

  @override
  Widget build(BuildContext context) => OptimusToggleButton(
        label: widget.hasLabel ? Text(_label) : null,
        isToggled: _isToggled,
        isLoading: _isLoading,
        onPressed: widget.isEnabled
            ? () {
                setState(() {
                  _isLoading = true;
                });
                Future.delayed(
                  const Duration(seconds: 2),
                  () => setState(() {
                    _isToggled = !_isToggled;
                    _label = _isToggled ? 'Claimed' : 'Claim';
                    _isLoading = false;
                  }),
                );
              }
            : null,
        size: widget.size,
      );
}
