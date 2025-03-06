import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Segmented Control',
  type: OptimusSegmentedControl,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final label = k.string(label: 'Label', initialValue: '');
  final error = k.string(label: 'Error', initialValue: '');
  final direction = k.list(
    label: 'Direction',
    initialOption: Axis.horizontal,
    options: Axis.values,
    labelBuilder: enumLabelBuilder,
  );
  final maxLines = k.int.slider(
    label: 'Max Lines:',
    description:
        'Max lines for the vertical layout. Horizontal layout will always be set to 1 line max.',
    initialValue: 1,
    min: 1,
    max: 3,
  );
  final size = k.widgetSizeKnob;
  final isEnabled = k.isEnabledKnob;
  final isRequired = k.boolean(label: 'Required', initialValue: false);
  final width =
      k.double.slider(label: 'Width', min: 200, initialValue: 600, max: 800);

  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _SegmentedControlExample(
                label: label,
                error: error,
                direction: direction,
                size: size,
                maxLines: maxLines,
                isEnabled: isEnabled,
                isRequired: isRequired,
                options: _options2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _SegmentedControlExample(
                label: label,
                error: error,
                direction: direction,
                size: size,
                maxLines: maxLines,
                isEnabled: isEnabled,
                isRequired: isRequired,
                options: _options3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _SegmentedControlExample(
                label: label,
                error: error,
                direction: direction,
                size: size,
                maxLines: maxLines,
                isEnabled: isEnabled,
                isRequired: isRequired,
                options: _options4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _SegmentedControlExample(
                label: label,
                error: error,
                direction: direction,
                size: size,
                maxLines: maxLines,
                isEnabled: isEnabled,
                isRequired: isRequired,
                options: _options5,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SegmentedControlExample extends StatefulWidget {
  const _SegmentedControlExample({
    required this.label,
    required this.error,
    required this.isEnabled,
    required this.isRequired,
    required this.options,
    required this.direction,
    required this.size,
    required this.maxLines,
  });

  final String label;
  final String error;
  final bool isEnabled;
  final bool isRequired;
  final List<String> options;
  final Axis direction;
  final OptimusWidgetSize size;
  final int maxLines;

  @override
  _SegmentedControlExampleState createState() =>
      _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<_SegmentedControlExample> {
  String _value = 'Another long option';

  void _handleItemSelected(String value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) => OptimusSegmentedControl<String>(
        value: _value,
        label: widget.label,
        size: widget.size,
        maxLines: widget.maxLines,
        isRequired: widget.isRequired,
        error: widget.error,
        isEnabled: widget.isEnabled,
        direction: widget.direction,
        onItemSelected: _handleItemSelected,
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
  'Option that is meant to overflow because of the long text',
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
