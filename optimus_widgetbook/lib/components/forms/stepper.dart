import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Stepper',
  type: OptimusStepperFormField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return _Content(
    isEnabled: k.isEnabledKnob,
    error: k.string(
      label: 'Validation error',
      initialValue: 'Validation error',
    ),
    size: k.widgetSizeKnob,
  );
}

class _Content extends StatefulWidget {
  const _Content({required this.isEnabled, required this.size, this.error});

  final bool isEnabled;
  final String? error;
  final OptimusWidgetSize size;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  int? _value = 8;

  void _handleChanged(int? value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Current value: ${_value ?? 0}'),
      const SizedBox(height: 16),
      OptimusStepperFormField(
        enabled: widget.isEnabled,
        size: widget.size,
        onChanged: _handleChanged,
        initialValue: 8,
        min: 5,
        max: 15,
        validationError: widget.error,
      ),
    ],
  );
}
