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

class _Content extends StatefulWidget {
  const _Content({
    Key? key,
    required this.isEnabled,
    this.error,
  }) : super(key: key);

  final bool isEnabled;
  final String? error;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: OptimusStack(
          spacing: OptimusStackSpacing.spacing200,
          children: [
            OptimusNumberPickerFormField(
              enabled: widget.isEnabled,
              initialValue: 5,
              min: 5,
              max: 15,
              onSaved: (v) {
                print('onSaved $v');
                // _onSubmitted();
                // setState(() => _value = v);
              },
              onChanged: (v) {
                print('onChanged $v');
              },
              error: widget.error,
            ),
            OptimusButton(
              variant: OptimusButtonVariant.primary,
              onPressed: _onSubmitted,
              child: const Text('Validate'),
            ),
          ],
        ),
      );

  void _onSubmitted() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState!.save();
    }
  }
}
