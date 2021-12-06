import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story numberPickerStory = Story(
  name: 'Number picker',
  builder: (_, k) => _Content(
    isEnabled: k.boolean(label: 'Enabled', initial: true),
    error: k.text(label: 'Validation error', initial: 'Validation error'),
  ),
);

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.isEnabled,
    this.error,
  }) : super(key: key);

  final bool isEnabled;
  final String? error;

  @override
  Widget build(BuildContext context) => OptimusNumberPickerFormField(
        enabled: isEnabled,
        initialValue: 8,
        onChanged: print,
        min: 5,
        max: 15,
        validationError: error,
      );
}
