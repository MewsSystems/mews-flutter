import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Toggle',
  type: OptimusToggleButton,
  path: '[Buttons]/Toggle',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final isEnabled = k.boolean(label: 'Enabled', initialValue: true);
  final size = k.list(
    label: 'Size',
    labelBuilder: (option) => option.name,
    initialOption: OptimusToggleButtonSizeVariant.large,
    options: OptimusToggleButtonSizeVariant.values,
  );
  final hasLabel = k.boolean(label: 'Label', initialValue: true);

  return Center(
    child: _ToggleExample(hasLabel: hasLabel, isEnabled: isEnabled, size: size),
  );
}

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

  void _handlePressed() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), _handleToggleBack);
  }

  void _handleToggleBack() {
    setState(() {
      _isToggled = !_isToggled;
      _label = _isToggled ? 'Claimed' : 'Claim';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) => OptimusToggleButton(
        label: widget.hasLabel ? Text(_label) : null,
        isToggled: _isToggled,
        isLoading: _isLoading,
        onPressed: widget.isEnabled ? _handlePressed : null,
        size: widget.size,
      );
}
