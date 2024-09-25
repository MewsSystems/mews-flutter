import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Date Input Field',
  type: OptimusDateInputField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const _DateFieldExample();

class _DateFieldExample extends StatefulWidget {
  const _DateFieldExample();

  @override
  State<_DateFieldExample> createState() => _DateFieldExampleState();
}

class _DateFieldExampleState extends State<_DateFieldExample> {
  late DateTime? _value;

  @override
  void initState() {
    super.initState();
    _value = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

    final isEnabled = k.boolean(label: 'Enabled', initialValue: true);
    final error = k.string(label: 'Error');
    final isClearEnabled = k.boolean(label: 'Clear all', initialValue: false);
    final String format = k.list(
      label: 'Format',
      options: _formats,
      initialOption: _formats.first,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusDateInputField(
        label: 'Date',
        value: _value,
        error: error.isNotEmpty ? error : null,
        isEnabled: isEnabled,
        format: DateFormat(format),
        isClearAllEnabled: isClearEnabled,
        onSubmitted: (value) => setState(() => _value = value),
      ),
    );
  }
}

const List<String> _formats = [
  'dd.MM.yyyy',
  'MM/dd/yyyy',
  'dd/MM/yyyy, HH:mm',
];
