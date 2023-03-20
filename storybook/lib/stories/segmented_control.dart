import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story segmentedControlStory = Story(
  name: 'Forms/Segmented control',
  builder: (context) {
    final k = context.knobs;
    final label = k.text(label: 'Label', initial: '');
    final error = k.text(label: 'Error', initial: '');
    final direction = k.options(
      label: 'Direction',
      initial: Axis.horizontal,
      options: Axis.values.toOptions(),
    );
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final isRequired = k.boolean(label: 'Required', initial: false);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: spacing100),
            child: _SegmentedControlExample(
              label: label,
              error: error,
              direction: direction,
              isEnabled: isEnabled,
              isRequired: isRequired,
              options: _options2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: spacing100),
            child: _SegmentedControlExample(
              label: label,
              error: error,
              direction: direction,
              isEnabled: isEnabled,
              isRequired: isRequired,
              options: _options3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: spacing100),
            child: _SegmentedControlExample(
              label: label,
              error: error,
              direction: direction,
              isEnabled: isEnabled,
              isRequired: isRequired,
              options: _options4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: spacing100),
            child: _SegmentedControlExample(
              label: label,
              error: error,
              direction: direction,
              isEnabled: isEnabled,
              isRequired: isRequired,
              options: _options5,
            ),
          )
        ],
      ),
    );
  },
);

class _SegmentedControlExample extends StatefulWidget {
  const _SegmentedControlExample({
    Key? key,
    required this.label,
    required this.error,
    required this.isEnabled,
    required this.isRequired,
    required this.options,
    required this.direction,
  }) : super(key: key);

  final String label;
  final String error;
  final bool isEnabled;
  final bool isRequired;
  final List<String> options;
  final Axis direction;

  @override
  _SegmentedControlExampleState createState() =>
      _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<_SegmentedControlExample> {
  String _value = 'Another long option';

  @override
  Widget build(BuildContext context) => OptimusSegmentedControl<String>(
        value: _value,
        label: widget.label,
        isRequired: widget.isRequired,
        error: widget.error,
        isEnabled: widget.isEnabled,
        direction: widget.direction,
        onItemSelected: (value) => setState(() => _value = value),
        items: widget.options
            .map((i) => OptimusGroupItem<String>(label: Text(i), value: i))
            .toList(),
      );
}

const _options2 = [
  'Another long option',
  'B',
];

const _options3 = [
  'Another long option',
  'B',
  'C',
];

const _options4 = [
  'Another long option',
  'B',
  'C',
  'D',
];

const _options5 = [
  'Another long option',
  'Option that is meant to break a line \n Second line text \n several times',
  'C',
  'D',
];
