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
    Key? key,
    int? initialValue,
    int min = 0,
    int max = 100,
    FormFieldSetter<int>? onSaved,
    ValueChanged<int?>? onChanged,
    AutovalidateMode autovalidateMode = AutovalidateMode.always,
    String? validationError,
    final bool enabled = true,
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
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: (value) => value != null && (value >= min && value <= max)
              ? null
              : validationError,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<int> field) {
            void _onChanged(int? value) {
              field.didChange(value);
              if (onChanged != null &&
                  (value == null || value >= min && value <= max)) {
                onChanged(value);
              }
            }

            return _OptimusNumberPicker(
              initialValue: initialValue,
              min: min,
              max: max,
              onChanged: _onChanged,
              enabled: enabled,
              error: field.errorText,
              focusNode: focusNode,
              controller: controller,
            );
          },
        );
}

class _OptimusNumberPicker extends StatefulWidget {
  const _OptimusNumberPicker({
    Key? key,
    required this.onChanged,
    this.initialValue,
    this.min = 0,
    this.max = 100,
    this.focusNode,
    this.enabled = true,
    this.error,
    this.controller,
  }) : super(key: key);

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

  void _initValue() {
    final controller = widget.controller;
    if (controller != null) {
      _value = int.tryParse(controller.text);
    } else {
      _value = widget.initialValue;
    }
  }

  @override
  void initState() {
    super.initState();

    _initValue();
    _updateController(_value);
    _effectiveController.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _effectiveController.removeListener(_controllerListener);
    _controller?.dispose();
    super.dispose();
  }

  void _onMinusTap() {
    final value = _value;
    late final int newValue;
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

  void _onPlusTap() {
    final value = _value;
    late final int newValue;
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
    _value = int.tryParse(v);
    widget.onChanged(_value);
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
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 134),
        child: OptimusInputField(
          textAlign: TextAlign.center,
          error: widget.error,
          isEnabled: widget.enabled,
          keyboardType: TextInputType.number,
          controller: _effectiveController,
          prefix: NumberPickerButton(
            iconData: OptimusIcons.minus_simple,
            onPressed:
                _value == null || _value! > widget.min ? _onMinusTap : null,
          ),
          suffix: NumberPickerButton(
            iconData: OptimusIcons.plus_simple,
            onPressed:
                _value == null || _value! < widget.max ? _onPlusTap : null,
          ),
          focusNode: _effectiveFocusNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(_integersOrEmptyString),
          ],
          onChanged: _onChanged,
        ),
      );
}

final _integersOrEmptyString = RegExp(r'^$|^[-]?\d+|^[-]');
