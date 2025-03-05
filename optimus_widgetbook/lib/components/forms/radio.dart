import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Radio',
  type: OptimusRadio,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final size = k.list(
    label: 'Size',
    initialOption: OptimusRadioSize.large,
    options: OptimusRadioSize.values,
    labelBuilder: enumLabelBuilder,
  );
  final error = k.string(label: 'Error', initialValue: '');
  final isEnabled = k.isEnabledKnob;

  return RadioExample(size: size, error: error, isEnabled: isEnabled);
}

class RadioExample extends StatefulWidget {
  const RadioExample({
    super.key,
    required this.size,
    required this.error,
    required this.isEnabled,
  });

  final OptimusRadioSize size;
  final String error;
  final bool isEnabled;

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String _groupValue = _options.first;

  void _handleChanged(String newValue) =>
      setState(() => _groupValue = newValue);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _options
                  .map(
                    (i) => OptimusRadio<String>(
                      isEnabled: widget.isEnabled,
                      label: Text(i),
                      size: widget.size,
                      value: i,
                      groupValue: _groupValue,
                      onChanged: _handleChanged,
                      error: widget.error,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}

@widgetbook.UseCase(
  name: 'Radio Group',
  type: OptimusRadioGroup,
  path: '[Forms]',
)
Widget createRadioGroup(BuildContext context) {
  final k = context.knobs;
  final size = k.list(
    label: 'Size',
    initialOption: OptimusRadioSize.large,
    options: OptimusRadioSize.values,
    labelBuilder: enumLabelBuilder,
  );
  final label = k.string(label: 'Label', initialValue: '');
  final error = k.string(label: 'Error', initialValue: '');
  final isEnabled = k.isEnabledKnob;

  return _RadioGroupExample(
    size: size,
    label: label,
    error: error,
    isEnabled: isEnabled,
  );
}

class _RadioGroupExample extends StatefulWidget {
  const _RadioGroupExample({
    required this.size,
    required this.label,
    required this.error,
    required this.isEnabled,
  });

  final OptimusRadioSize size;
  final String label;
  final String error;
  final bool isEnabled;

  @override
  _RadioGroupExampleState createState() => _RadioGroupExampleState();
}

class _RadioGroupExampleState extends State<_RadioGroupExample> {
  String _groupValue = '';

  void _handleChanged(String value) => setState(() => _groupValue = value);

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: 400,
          child: OptimusRadioGroup<String>(
            size: widget.size,
            value: _groupValue,
            label: widget.label,
            error: widget.error,
            isEnabled: widget.isEnabled,
            onChanged: _handleChanged,
            items: _options
                .map((i) => OptimusGroupItem<String>(label: Text(i), value: i))
                .toList(),
          ),
        ),
      );
}

const _options = [
  'Option A with a long text \ntaking several lines',
  'Option B',
  'Option C',
  'Option D',
];
