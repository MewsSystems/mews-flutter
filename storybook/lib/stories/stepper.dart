import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story stepperStory = Story(
  name: 'Forms/Stepper',
  builder: (context) {
    final k = context.knobs;

    return _Content(
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      error: k.text(label: 'Validation error', initial: 'Validation error'),
      size: k.options(
        label: 'Size',
        initial: OptimusWidgetSize.large,
        options: OptimusWidgetSize.values.toOptions(),
      ),
    );
  },
);

class _Content extends StatefulWidget {
  const _Content({
    required this.isEnabled,
    required this.size,
    this.error,
  });

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
