import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story formStory = Story(
  name: 'Form',
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
    final error = widget.knobs.text(label: 'Error', initial: 'Required');
    final autovalidateMode = widget.knobs.options(
      label: 'autovalidateMode',
      initial: AutovalidateMode.onUserInteraction,
      options: [
        const Option('disabled', AutovalidateMode.disabled),
        const Option('always', AutovalidateMode.always),
        const Option('onUserInteraction', AutovalidateMode.onUserInteraction),
      ],
    );
    final notEmpty = (String? v) => v?.isNotEmpty != true ? error : null;
    final isRequired = widget.knobs.boolean(label: 'Required', initial: true);

    return Form(
      key: _formKey,
      child: OptimusStack(
        mainAxisSize: MainAxisSize.min,
        spacing: OptimusStackSpacing.spacing300,
        children: [
          OptimusInputFormField(
            label: 'Input form field',
            isRequired: isRequired,
            validator: notEmpty,
          ),
          OptimusSelectFormField<String?>(
            label: 'Item selector',
            isRequired: isRequired,
            placeholder: 'Please select the item',
            initialValue: null,
            builder: (context, value) =>
                value == null ? const Text('') : Text(value),
            items: _selectorItems
                .map((e) => ListDropdownTile<String>(value: e, title: Text(e)))
                .toList(),
            validator: notEmpty,
            autovalidateMode: autovalidateMode,
          ),
          OptimusCheckBoxFormField(
            label: const Text('Checkbox form field'),
            isRequired: isRequired,
            validator: (isChecked) => isChecked == true ? null : error,
            autovalidateMode: autovalidateMode,
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

final _selectorItems = List.generate(10, (i) => 'Item $i');
