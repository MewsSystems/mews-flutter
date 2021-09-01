import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dateTimeFieldStory =
    Story(name: 'Date time field', builder: (_, k) => _Content(k: k));

class _Content extends StatefulWidget {
  const _Content({Key? key, required this.k}) : super(key: key);

  final KnobsBuilder k;

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

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: OptimusDateTimeField(
          value: _dateTime,
          isClearAllEnabled:
              widget.k.boolean(label: 'Clear all', initial: false),
          label: widget.k.text(label: 'Label', initial: 'Optimus input field'),
          error: widget.k.text(label: 'Error', initial: ''),
          placeholder: widget.k.text(label: 'Placeholder', initial: ''),
          formatDateTime: DateFormat().format,
          onChanged: (v) => setState(() {
            _dateTime = v;
          }),
        ),
      );
}
