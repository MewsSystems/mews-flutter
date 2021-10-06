import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/number_picker/button.dart';

class OptimusNumberPickerFormField extends FormField<int> {
  OptimusNumberPickerFormField({
    Key? key,
    int initialValue = 0,
    int defaultValue = 0,
    int min = 0,
    int max = 100,
    FormFieldSetter<int>? onSaved,
    ValueChanged<int>? onChanged,
    AutovalidateMode autovalidateMode = AutovalidateMode.always,
    String? error,
    final bool enabled = true,
    FocusNode? focusNode,
  })  : assert(
          min <= initialValue && initialValue <= max,
          'initial value should be in [min, max] range',
        ),
        assert(
          min <= defaultValue && defaultValue <= max,
          'defaultValue value should be in [min, max] range',
        ),
        super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: (value) =>
              value != null && value >= min && value <= max ? null : error,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<int> field) => _OptimusNumberPicker(
            initialValue: initialValue,
            defaultValue: defaultValue,
            min: min,
            max: max,
            onChanged: (value) {
              field.didChange(value);
              if (onChanged != null && value >= min && value <= max) {
                onChanged(value);
              }
            },
            enabled: enabled,
            error: field.errorText,
            focusNode: focusNode,
          ),
        );
}

class _OptimusNumberPicker extends StatefulWidget {
  const _OptimusNumberPicker({
    Key? key,
    required this.onChanged,
    this.initialValue = 0,
    this.defaultValue = 0,
    this.min = 0,
    this.max = 100,
    this.focusNode,
    this.enabled = true,
    this.error,
  }) : super(key: key);

  final int initialValue;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final int defaultValue;
  final FocusNode? focusNode;
  final bool enabled;
  final String? error;

  @override
  _OptimusNumberPickerState createState() => _OptimusNumberPickerState();
}

class _OptimusNumberPickerState extends State<_OptimusNumberPicker> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue.toString());
  FocusNode? _focusNode;
  late int _value = widget.initialValue;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void dispose() {
    _controller.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  void _onMinusTap() {
    final value = _value < widget.min + 1
        ? widget.min
        : _value > widget.max
            ? widget.max
            : _value - 1;
    _updateValue(value);
    _updateController(value);
  }

  void _onPlusTap() {
    final value = _value < widget.min
        ? widget.min
        : _value > widget.max - 1
            ? widget.max
            : _value + 1;
    _updateValue(value);
    _updateController(value);
  }

  void _updateValue(int value) {
    _value = value;
    widget.onChanged(value);
  }

  void _updateController(int value) {
    final newValue = value.toString();
    _controller
      ..text = newValue
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: newValue.length),
      );
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 134),
        child: OptimusInputField(
          textAlign: TextAlign.center,
          error: widget.error,
          isEnabled: widget.enabled,
          keyboardType: TextInputType.number,
          controller: _controller,
          prefix: NumberPickerButton(
            iconData: OptimusIcons.minus_simple,
            onPressed: _value > widget.min ? _onMinusTap : null,
          ),
          suffix: NumberPickerButton(
            iconData: OptimusIcons.plus_simple,
            onPressed: _value < widget.max ? _onPlusTap : null,
          ),
          focusNode: _effectiveFocusNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(_integersOrEmptyString),
          ],
          placeholder: widget.defaultValue.toString(),
          onChanged: (v) => v.isEmpty
              ? _updateValue(widget.defaultValue)
              : _updateValue(int.tryParse(v) ?? widget.defaultValue),
        ),
      );
}

final _integersOrEmptyString = RegExp(r'^$|^[-]?\d+|^[-]');
