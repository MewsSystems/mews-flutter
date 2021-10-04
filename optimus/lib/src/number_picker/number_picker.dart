import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/number_picker/button.dart';

class OptimusNumberPickerFormField extends FormField<int?> {
  OptimusNumberPickerFormField({
    Key? key,
    int initialValue = 0,
    int min = 0,
    int max = 100,
    int defaultValue = 0,
    FormFieldSetter<int>? onSaved,
    ValueChanged<int?>? onChanged,
    AutovalidateMode autovalidateMode = AutovalidateMode.always,
    String? error,
    final bool enabled = true,
    FocusNode? focusNode,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: (value) =>
              value != null && value >= min && value <= max ? null : error,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<int?> field) => OptimusNumberPicker(
            value: field.value,
            initialValue: initialValue,
            defaultValue: defaultValue,
            min: min,
            max: max,
            // ignore: prefer-extracting-callbacks
            onChanged: (value) {
              field.didChange(value);
              if (onChanged != null &&
                  value != null &&
                  value >= min &&
                  value <= max) {
                onChanged(value);
              }
            },
            enabled: enabled,
            error: field.errorText,
            focusNode: focusNode,
          ),
        );
}

class OptimusNumberPicker extends StatefulWidget {
  const OptimusNumberPicker({
    Key? key,
    this.value,
    required this.onChanged,
    this.initialValue = 0,
    this.defaultValue = 0,
    this.min = 0,
    this.max = 100,
    this.focusNode,
    this.enabled = true,
    this.error,
    this.readOnly = false,
    this.showCursor,
  })  : assert(
          min <= initialValue && initialValue <= max,
          'initial value should be in [min, max] range',
        ),
        assert(
          min <= defaultValue && defaultValue <= max,
          'defaultValue value should be in [min, max] range',
        ),
        super(key: key);

  final int? value;
  final int initialValue;
  final ValueChanged<int?> onChanged;
  final int min;
  final int max;
  final int defaultValue;
  final FocusNode? focusNode;
  final bool enabled;
  final String? error;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  @override
  _OptimusNumberPickerState createState() => _OptimusNumberPickerState();
}

class _OptimusNumberPickerState extends State<OptimusNumberPicker> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  void _onMinusTap() {
    final int? newValue;
    if (widget.value == null || widget.value! < widget.min + 1) {
      newValue = widget.min;
    } else if (widget.value! > widget.max) {
      newValue = widget.max;
    } else {
      newValue = widget.value! - 1;
    }
    _updateValue(newValue);
  }

  void _onPlusTap() {
    final int? newValue;
    if (widget.value == null || widget.value! < widget.min) {
      newValue = widget.min;
    } else if (widget.value! > widget.max - 1) {
      newValue = widget.max;
    } else {
      newValue = widget.value! + 1;
    }
    _updateValue(newValue);
  }

  void _updateValue(int? newValue) {
    widget.onChanged(newValue);
    _controller?.text = _format(newValue);
    _controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: _format(newValue).length),
    );
  }

  bool get _canSubtract =>
      widget.value == null ? true : widget.value! > widget.min;

  bool get _canAdd => widget.value == null ? true : widget.value! < widget.max;

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
            onPressed: _canSubtract ? _onMinusTap : null,
          ),
          suffix: NumberPickerButton(
            iconData: OptimusIcons.plus_simple,
            onPressed: _canAdd ? _onPlusTap : null,
          ),
          focusNode: _effectiveFocusNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(_integersOrEmptyString),
          ],
          placeholder: widget.defaultValue.toString(),
          onChanged: (v) => v.isEmpty
              ? widget.onChanged(widget.defaultValue)
              : widget.onChanged(int.tryParse(v)),
          readOnly: widget.readOnly,
          showCursor: widget.showCursor,
        ),
      );
}

String _format(int? value) => value?.toString() ?? '';

final _integersOrEmptyString = RegExp(r'^$|^[-]?\d+|^[-]');
