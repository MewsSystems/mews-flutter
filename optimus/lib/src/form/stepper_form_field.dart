import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';

class OptimusStepperFormField extends FormField<int> {
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue].
  OptimusStepperFormField({
    super.key,
    String? label,
    String? semanticLabel,
    int? initialValue,
    int min = 0,
    int max = 100,
    super.onSaved,
    ValueChanged<int?>? onChanged,
    AutovalidateMode super.autovalidateMode = .always,
    String? validationError,
    super.enabled,
    FocusNode? focusNode,
    TextEditingController? controller,
    OptimusWidgetSize size = .large,
    String? increaseSemanticLabel,
    String? decreaseSemanticLabel,
    double maxWidth = 200,
  }) : assert(
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
         builder: (FormFieldState<int> field) => _Stepper(
           label: label,
           semanticLabel: semanticLabel,
           initialValue: initialValue,
           min: min,
           max: max,
           increaseSemanticLabel: increaseSemanticLabel,
           decreaseSemanticLabel: decreaseSemanticLabel,
           onChanged: (value) {
             field.didChange(value);
             onChanged?.call(value);
           },
           isEnabled: enabled,
           error: field.errorText,
           focusNode: focusNode,
           controller: controller,
           size: size,
           maxWidth: maxWidth,
         ),
       );
}

class _Stepper extends StatefulWidget {
  const _Stepper({
    required this.onChanged,
    this.label,
    this.semanticLabel,
    this.initialValue,
    this.min = 0,
    this.max = 100,
    this.focusNode,
    this.isEnabled = true,
    this.error,
    this.controller,
    this.size = OptimusWidgetSize.large,
    this.decreaseSemanticLabel,
    this.increaseSemanticLabel,
    this.maxWidth = 200,
  });

  final String? label;
  final String? semanticLabel;
  final int? initialValue;
  final ValueChanged<int?> onChanged;
  final int min;
  final int max;
  final FocusNode? focusNode;
  final bool isEnabled;
  final String? error;
  final TextEditingController? controller;
  final OptimusWidgetSize size;
  final String? increaseSemanticLabel;
  final String? decreaseSemanticLabel;
  final double maxWidth;

  @override
  _StepperState createState() => .new();
}

class _StepperState extends State<_Stepper> {
  int? _value;

  TextEditingController? _controller;
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode {
    if (widget.focusNode case final focusNode?) return focusNode;

    return _focusNode ??= FocusNode();
  }

  TextEditingController get _effectiveController {
    if (widget.controller case final controller?) return controller;

    return _controller ??= TextEditingController(
      text: widget.initialValue?.toString() ?? '',
    );
  }

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

  void _handleMinusTap() => _updateController(_decreasedValue);

  void _handlePlusTap() => _updateController(_increasedValue);

  int get _increasedValue =>
      ((_value ?? widget.min) + 1).clamp(widget.min, widget.max);

  int get _decreasedValue =>
      ((_value ?? widget.max) - 1).clamp(widget.min, widget.max);

  void _onChanged(String v) {
    final value = int.tryParse(v);
    if (value != null && value >= widget.min && value <= widget.max) {
      widget.onChanged(value);
    } else {
      widget.onChanged(null);
    }
    _value = value;
  }

  void _updateController(int value) {
    final newValue = value.toString();
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
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: Semantics(
        value: value?.toString(),
        increasedValue: _increasedValue.toString(),
        decreasedValue: _decreasedValue.toString(),
        onIncrease: _handlePlusTap,
        onDecrease: _handleMinusTap,
        child: OptimusInputField(
          label: widget.label,
          semanticsLabel: widget.semanticLabel,
          size: widget.size,
          textAlign: .center,
          error: widget.error,
          isEnabled: widget.isEnabled,
          controller: _effectiveController,
          leading: _StepperButton(
            iconData: OptimusIcons.minus_simple,
            semanticLabel: widget.decreaseSemanticLabel,
            onPressed: widget.isEnabled
                ? value == null || value > widget.min
                      ? _handleMinusTap
                      : null
                : null,
          ),
          trailing: _StepperButton(
            iconData: OptimusIcons.plus_simple,
            semanticLabel: widget.increaseSemanticLabel,
            onPressed: widget.isEnabled
                ? value == null || value < widget.max
                      ? _handlePlusTap
                      : null
                : null,
          ),
          focusNode: _effectiveFocusNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(_integersOrEmptyString),
          ],
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.iconData,
    this.onPressed,
    this.semanticLabel,
  });

  final IconData iconData;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  bool get _isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return OptimusEnabled(
      isEnabled: _isEnabled,
      child: Semantics(
        label: semanticLabel,
        child: GestureDetector(
          onTap: onPressed,
          child: Icon(
            iconData,
            color: _isEnabled ? tokens.textStaticPrimary : tokens.textDisabled,
            size: tokens.sizing300,
          ),
        ),
      ),
    );
  }
}

final _integersOrEmptyString = RegExp(r'^$|^[-]?\d+|^[-]');
