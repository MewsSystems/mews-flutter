import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Form',
  type: Form,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const _Content();

class _Content extends StatefulWidget {
  const _Content();

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _values = [];

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final error = k.string(label: 'Error', initialValue: 'Required');
    final AutovalidateMode autovalidateMode = k.list(
      label: 'autovalidateMode',
      initialOption: AutovalidateMode.onUserInteraction,
      options: AutovalidateMode.values,
    );
    final allowMultipleSelection =
        k.boolean(label: 'Multiselect', initialValue: false);

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
                .map(
                  (e) => ListDropdownTile<String>(
                    value: e,
                    title: Text(e),
                    isSelected:
                        allowMultipleSelection ? _values.contains(e) : null,
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (_values.contains(v)) {
                setState(() => _values.remove(v));
              } else {
                if (v != null) {
                  setState(() => _values.add(v));
                }
              }
            },
            validator: (String? v) => v?.isNotEmpty != true ? error : null,
            autovalidateMode: autovalidateMode,
            allowMultipleSelection: allowMultipleSelection,
            values: _values,
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
