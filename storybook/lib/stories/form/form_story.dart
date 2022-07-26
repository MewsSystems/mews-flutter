import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story formStory = Story(
  name: 'Forms/Form',
  builder: (context) => _Content(context.knobs),
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
        const Option(label: 'disabled', value: AutovalidateMode.disabled),
        const Option(label: 'always', value: AutovalidateMode.always),
        const Option(
          label: 'onUserInteraction',
          value: AutovalidateMode.onUserInteraction,
        ),
      ],
    );

    return Form(
      key: _formKey,
      child: OptimusStack(
        mainAxisSize: MainAxisSize.min,
        spacing: OptimusStackSpacing.spacing300,
        children: [
          OptimusCheckBoxFormField(
            label: const Text('Checkbox form field'),
            validator: (isChecked) => isChecked == true ? null : error,
            autovalidateMode: autovalidateMode,
          ),
          OptimusSelectInputFormField<String?>(
            label: 'Item selector',
            placeholder: 'Please select the item',
            initialValue: null,
            builder: (value) => value ?? '',
            items: _selectorItems
                .map((e) => ListDropdownTile<String>(value: e, title: Text(e)))
                .toList(),
            validator: (String? v) => v?.isNotEmpty != true ? error : null,
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
