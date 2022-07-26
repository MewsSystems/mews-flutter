import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story numberPickerStory = Story(
  name: 'Forms/Number picker',
  builder: (context) {
    final k = context.knobs;

    return _Content(
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      error: k.text(label: 'Validation error', initial: 'Validation error'),
    );
  },
);

class _Content extends StatefulWidget {
  const _Content({
    Key? key,
    required this.isEnabled,
    this.error,
  }) : super(key: key);

  final bool isEnabled;
  final String? error;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  int? _value = 8;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current value: $_value'),
          const SizedBox(height: 16),
          OptimusNumberPickerFormField(
            enabled: widget.isEnabled,
            onChanged: (v) => setState(() => _value = v),
            initialValue: 8,
            min: 5,
            max: 15,
            validationError: widget.error,
          ),
        ],
      );
}
