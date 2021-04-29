import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story checkboxFormStory = Story(
  name: 'Checkbox form field',
  section: 'Form',
  builder: (_, k) => _Content(k),
);

class _Content extends StatefulWidget {
  const _Content(this.knobs, {Key? key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final error = widget.knobs.text(label: 'Error', initial: 'Error');

    return Form(
      key: _formKey,
      child: OptimusStack(
        mainAxisSize: MainAxisSize.min,
        spacing: OptimusStackSpacing.spacing300,
        children: [
          OptimusCheckBoxFormField(
            label: const Text('Checkbox form field'),
            validator: (isChecked) => isChecked == true ? null : error,
          ),
          OptimusButton(
            onPressed: () => _formKey.currentState?.validate(),
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}
