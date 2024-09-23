import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Date Time Field',
  type: OptimusDateTimeField,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const _Content();

class _Content extends StatefulWidget {
  const _Content();

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  DateTime? _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
  }

  void _handleChanged(DateTime? dateTime) =>
      setState(() => _dateTime = dateTime);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: OptimusDateTimeField(
        value: _dateTime,
        isClearEnabled: k.boolean(label: 'Clear all', initialValue: false),
        label: k.string(label: 'Label', initialValue: 'Date'),
        error: k.string(label: 'Error', initialValue: ''),
        placeholder: k.string(label: 'Placeholder', initialValue: ''),
        isEnabled: k.boolean(label: 'Enabled', initialValue: true),
        formatDateTime: (d) {
          final am = d.hour < 12 ? 'AM' : 'PM';
          final hours = d.hour % 12;

          return '${d.day}/${d.month}/${d.year} ${hours.padded()}:${d.minute.padded()} $am';
        },
        onChanged: _handleChanged,
      ),
    );
  }
}

extension on int {
  String padded() => toString().padLeft(2, '0');
}
