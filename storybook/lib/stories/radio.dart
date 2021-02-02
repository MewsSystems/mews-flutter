import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story radioStory = Story(
  section: 'Radio',
  name: 'Radio',
  builder: (_, k) {
    final size = k.options('Size', initial: OptimusRadioSize.large, options: _sizes);
    final error = k.text('Error', initial: '');
    final isEnabled = k.boolean('Enabled', initial: true);

    return RadioExample(size: size, error: error, isEnabled: isEnabled);
  },
);

class RadioExample extends StatefulWidget {
  const RadioExample({
    Key key,
    @required this.size,
    @required this.error,
    @required this.isEnabled,
  }) : super(key: key);

  final OptimusRadioSize size;
  final String error;
  final bool isEnabled;

  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String _groupValue = _options.first;

  void _onChanged(String newValue) {
    setState(() => _groupValue = newValue);
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _options
                .map((i) => OptimusRadio<String>(
                      isEnabled: widget.isEnabled,
                      label: Text(i),
                      size: widget.size,
                      value: i,
                      groupValue: _groupValue,
                      onChanged: _onChanged,
                      error: widget.error,
                    ))
                .toList()),
      );
}

final Story radioGroupStory = Story(
  section: 'Radio',
  name: 'Radio group',
  builder: (_, k) {
    final size = k.options('Size', initial: OptimusRadioSize.large, options: _sizes);
    final label = k.text('Label', initial: '');
    final error = k.text('Error', initial: '');
    final isEnabled = k.boolean('Enabled', initial: true);

    return _RadioGroupExample(size: size, label: label, error: error, isEnabled: isEnabled);
  },
);

class _RadioGroupExample extends StatefulWidget {
  const _RadioGroupExample({
    Key key,
    @required this.size,
    @required this.label,
    @required this.error,
    @required this.isEnabled,
  }) : super(key: key);

  final OptimusRadioSize size;
  final String label;
  final String error;
  final bool isEnabled;

  @override
  _RadioGroupExampleState createState() => _RadioGroupExampleState();
}

class _RadioGroupExampleState extends State<_RadioGroupExample> {
  String _groupValue = '';

  @override
  Widget build(BuildContext context) => OptimusRadioGroup<String>(
        size: widget.size,
        value: _groupValue,
        label: widget.label,
        error: widget.error,
        isEnabled: widget.isEnabled,
        onChanged: (value) => setState(() => _groupValue = value),
        items: _options.map((i) => OptimusGroupItem<String>(label: Text(i), value: i)).toList(),
      );
}

const _options = ['Option A with a long text \ntaking several lines', 'Option B', 'Option C', 'Option D'];

final _sizes = OptimusRadioSize.values.toOptions();
