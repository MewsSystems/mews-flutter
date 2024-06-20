import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dateInputStory = Story(
  name: 'Forms/Date Input Field',
  builder: (context) => const _DateFieldExample(),
);

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

    final enabled = k.boolean(label: 'Enabled', initial: true);
    final error = k.text(label: 'Error');
    final isClearEnabled = k.boolean(label: 'Clear all', initial: false);
    final String format = k.options(
      label: 'Format',
      options: _formats,
      initial: _formats.first.value,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusDateInputField(
        label: 'Date',
        value: _value,
        error: error.isNotEmpty ? error : null,
        isEnabled: enabled,
        format: DateFormat(format),
        isClearAllEnabled: isClearEnabled,
        onSubmitted: (value) => setState(() => _value = value),
      ),
    );
  }
}

const List<Option<String>> _formats = [
  Option(label: 'dd.MM.yyyy', value: 'dd.MM.yyyy'),
  Option(label: 'MM/dd/yyyy', value: 'MM/dd/yyyy'),
  Option(label: 'dd/MM/yyyy, HH:mm', value: 'dd/MM/yyyy, HH:mm'),
];
