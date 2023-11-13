import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/number_picker/button.dart';

class OptimusNumberPickerFormField extends FormField<int> {
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue].
  OptimusNumberPickerFormField({
    super.key,
    int? initialValue,
    int min = 0,
    int max = 100,
    super.onSaved,
    ValueChanged<int?>? onChanged,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.always,
    String? validationError,
    super.enabled,
    FocusNode? focusNode,
    TextEditingController? controller,
  })  : assert(
          initialValue == null || controller == null,
          'initialValue or controller must be null',
        ),
        assert(
          initialValue == null || initialValue >= min && initialValue <= max,
          'initial value should be null or in [min, max] range',
        ),
        super(
          initialValue: initialValue ?? int.tryParse(controller?.text ?? ''),
          validator: (value) => value != null && (value >= min && value <= max)
              ? null
              : validationError,
          builder: (FormFieldState<int> field) => _OptimusNumberPicker(
            initialValue: initialValue,
            min: min,
            max: max,
            onChanged: (value) {
              field.didChange(value);
              onChanged?.call(value);
            },
            enabled: enabled,
            error: field.errorText,
            focusNode: focusNode,
            controller: controller,
          ),
        );
}

class _OptimusNumberPicker extends StatefulWidget {
  const _OptimusNumberPicker({
    required this.onChanged,
    this.initialValue,
    this.min = 0,
    this.max = 100,
    this.focusNode,
    this.enabled = true,
    this.error,
    this.controller,
  });

  final int? initialValue;
  final ValueChanged<int?> onChanged;
  final int min;
  final int max;
  final FocusNode? focusNode;
  final bool enabled;
  final String? error;
  final TextEditingController? controller;

  @override
  _OptimusNumberPickerState createState() => _OptimusNumberPickerState();
}

class _OptimusNumberPickerState extends State<_OptimusNumberPicker> {
  int? _value;

  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ??
      (_controller ??= TextEditingController(
        text: widget.initialValue?.toString() ?? '',
      ));

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _controllerListener() => _onChanged(_effectiveController.text);

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? int.tryParse(widget.controller?.text ?? '');
    _effectiveController.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _effectiveController.removeListener(_controllerListener);
    _controller?.dispose();
    super.dispose();
  }

  void _handleMinusTap() {
    final value = _value;
    final int newValue;
    if (value != null) {
      newValue = value < widget.min + 1
          ? widget.min
          : value > widget.max
              ? widget.max
              : value - 1;
    } else {
      newValue = widget.min;
    }
    _updateController(newValue);
  }

  void _handlePlusTap() {
    final value = _value;
    final int newValue;
    if (value != null) {
      newValue = value < widget.min
          ? widget.min
          : value > widget.max - 1
              ? widget.max
              : value + 1;
    } else {
      newValue = widget.min;
    }
    _updateController(newValue);
  }

  void _onChanged(String v) {
    final value = int.tryParse(v);
    if (value != null && value >= widget.min && value <= widget.max) {
      widget.onChanged(value);
    } else {
      widget.onChanged(null);
    }
    _value = value;
  }

  void _updateController(int? value) {
    final newValue = value?.toString() ?? '';
    _effectiveController
      ..text = newValue
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: newValue.length),
      );
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 134),
      child: OptimusInputField(
        textAlign: TextAlign.center,
        error: widget.error,
        isEnabled: widget.enabled,
        keyboardType: TextInputType.number,
        controller: _effectiveController,
        leading: NumberPickerButton(
          iconData: OptimusIcons.minus_simple,
          onPressed:
              value == null || value > widget.min ? _handleMinusTap : null,
        ),
        trailing: NumberPickerButton(
          iconData: OptimusIcons.plus_simple,
          onPressed:
              value == null || value < widget.max ? _handlePlusTap : null,
        ),
        focusNode: _effectiveFocusNode,
        inputFormatters: [
          FilteringTextInputFormatter.allow(_integersOrEmptyString),
        ],
      ),
    );
  }
}

final _integersOrEmptyString = RegExp(r'^$|^[-]?\d+|^[-]');
