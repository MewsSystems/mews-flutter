import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story segmentedControlStory = Story(
  name: 'Segmented control',
  builder: (_, k) {
    // final label = k.text(label: 'Label', initial: '');
    // final error = k.text(label: 'Error', initial: '');
    // final isEnabled = k.boolean(label: 'Enabled', initial: true);

    return _SegmentedControlExample(
      label: 'Label',
      error: 'Error',
      isEnabled: true,
    );
  },
);

class _SegmentedControlExample extends StatefulWidget {
  const _SegmentedControlExample({
    Key? key,
    required this.label,
    required this.error,
    required this.isEnabled,
  }) : super(key: key);

  final String label;
  final String error;
  final bool isEnabled;

  @override
  _SegmentedControlExampleState createState() =>
      _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<_SegmentedControlExample> {
  String _groupValue = '';

  @override
  Widget build(BuildContext context) => OptimusSegmentedControl<String>(
        value: _groupValue,
        label: widget.label,
        error: widget.error,
        isEnabled: widget.isEnabled,
        onChanged: (value) => setState(() => _groupValue = value),
        items: _options
            .map((i) => OptimusGroupItem<String>(label: Text(i), value: i))
            .toList(),
      );
}

const _options = [
  'Another long option',
  'Bbb',
  'C',
  // 'D',
];
