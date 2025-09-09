import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();
final _radioGroupKey = GlobalKey();

@widgetbook.UseCase(name: 'Radio', type: OptimusRadio, path: '[Forms]')
Widget createDefaultStyle(BuildContext _) => RadioExample(key: _key);

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String _groupValue = _options.first;

  void _handleChanged(String newValue) =>
      setState(() => _groupValue = newValue);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final size = k.object.dropdown(
      label: 'Size',
      initialOption: OptimusRadioSize.large,
      options: OptimusRadioSize.values,
      labelBuilder: enumLabelBuilder,
    );
    final error = k.string(label: 'Error', initialValue: '');
    final isEnabled = k.isEnabledKnob;

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _options
                .map(
                  (i) => OptimusRadio<String>(
                    key: ValueKey(i),
                    isEnabled: isEnabled,
                    label: Text(i),
                    size: size,
                    value: i,
                    groupValue: _groupValue,
                    onChanged: _handleChanged,
                    error: error,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Radio Group',
  type: OptimusRadioGroup,
  path: '[Forms]',
)
Widget createRadioGroup(BuildContext _) =>
    _RadioGroupExample(key: _radioGroupKey);

class _RadioGroupExample extends StatefulWidget {
  const _RadioGroupExample({super.key});

  @override
  _RadioGroupExampleState createState() => _RadioGroupExampleState();
}

class _RadioGroupExampleState extends State<_RadioGroupExample> {
  String _groupValue = '';

  void _handleChanged(String value) => setState(() => _groupValue = value);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final size = k.object.dropdown(
      label: 'Size',
      initialOption: OptimusRadioSize.large,
      options: OptimusRadioSize.values,
      labelBuilder: enumLabelBuilder,
    );
    final label = k.string(label: 'Label', initialValue: '');
    final error = k.string(label: 'Error', initialValue: '');
    final isEnabled = k.isEnabledKnob;

    return Center(
      child: SizedBox(
        width: 400,
        child: OptimusRadioGroup<String>(
          size: size,
          value: _groupValue,
          label: label,
          error: error,
          isEnabled: isEnabled,
          onChanged: _handleChanged,
          items: _options
              .map((i) => OptimusGroupItem<String>(label: Text(i), value: i))
              .toList(),
        ),
      ),
    );
  }
}

const _options = [
  'Option A with a long text \ntaking several lines',
  'Option B',
  'Option C',
  'Option D',
];
