import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story numberPickerStory = Story(
  name: 'Number picker',
  builder: (_, k) => _Content(
    isEnabled: k.boolean(label: 'Enabled', initial: true),
    error: k.text(label: 'Error'),
  ),
);

class _Content extends StatefulWidget {
  const _Content({
    Key key,
    this.isEnabled,
    this.error,
  }) : super(key: key);

  final bool isEnabled;
  final String error;

  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  int _value;

  @override
  Widget build(BuildContext context) => OptimusNumberPicker(
        isEnabled: widget.isEnabled,
        value: _value,
        min: -5,
        max: 5,
        defaultValue: 0,
        onChanged: (v) => setState(() => _value = v),
        error: widget.error,
      );
}
