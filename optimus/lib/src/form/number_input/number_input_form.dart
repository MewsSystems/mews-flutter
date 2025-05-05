import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/number_input/string_formatter.dart';

/// A form field that allows the user to input a number.
/// The number is formatted according to the provided [precision] and
/// [separatorVariant]. See [OptimusNumberSeparatorVariant] for available
/// separator variants and [OptimusNumberInput] for more details.
class OptimusNumberInputFormField extends FormField<String> {
  OptimusNumberInputFormField({
    super.key,
    double? initialValue,
    this.controller,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    String? placeholder,
    bool isEnabled = true,
    ValueChanged<String>? onSubmitted,
    FocusNode? focusNode,
    String? label,
    bool isRequired = false,
    Widget? suffix,
    Widget? prefix,
    bool readOnly = false,
    Widget? helperMessage,
    OptimusWidgetSize size = OptimusWidgetSize.large,
    bool showLoader = false,
    this.precision = 2,
    this.separatorVariant = OptimusNumberSeparatorVariant.commaAndStop,
    this.min = 0,
    double max = 12,
    bool allowNegate = false,
    bool isInlined = false,
    double step = 1,
  }) : assert(
         initialValue == null || controller == null,
         'Provide either initial value or controller',
       ),
       super(
         initialValue:
             controller != null
                 ? controller.text.format(
                   precision: precision,
                   separatorVariant: separatorVariant,
                 )
                 : (initialValue?.toString().format(
                       precision: precision,
                       separatorVariant: separatorVariant,
                     ) ??
                     min.toString().format(
                       precision: precision,
                       separatorVariant: separatorVariant,
                     )),
         enabled: isEnabled,
         builder: (FormFieldState<String> field) {
           // ignore: avoid-type-casts, can't be anything else. No need to check
           final _InputFormFieldState state = field as _InputFormFieldState;

           return OptimusNumberInput(
             onChanged: field.didChange,
             placeholder: placeholder,
             isEnabled: isEnabled,
             onSubmitted: onSubmitted,
             focusNode: focusNode,
             label: label,
             controller: state._effectiveController,
             error: field.errorText,
             isRequired: isRequired,
             prefix: prefix,
             suffix: suffix,
             isReadOnly: readOnly,
             helperMessage: helperMessage,
             size: size,
             showLoader: showLoader,
             precision: precision,
             separatorVariant: separatorVariant,
             min: min,
             max: max,
             allowNegate: allowNegate,
             isInlined: isInlined,
             step: step,
           );
         },
       );

  final TextEditingController? controller;
  final int precision;
  final double min;
  final OptimusNumberSeparatorVariant separatorVariant;

  @override
  FormFieldState<String> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ??
      _controller!; // ignore: avoid-non-null-assertion, _controller would be
  // initialized at this point

  @override
  OptimusNumberInputFormField get widget =>
      // ignore: avoid-type-casts, can't be anything else. No need to check.
      super.widget as OptimusNumberInputFormField;

  @override
  void initState() {
    super.initState();
    final controller = widget.controller;
    if (controller == null) {
      _controller = TextEditingController(
        text: _formatValue(widget.initialValue ?? _fallbackValue),
      );
    } else {
      controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OptimusNumberInputFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      final oldWidgetController = oldWidget.controller;
      final widgetController = widget.controller;

      if (oldWidgetController != null && widgetController == null) {
        _controller = TextEditingController.fromValue(
          oldWidgetController.value,
        );
      }
      if (widgetController != null) {
        setValue(_formatValue(widgetController.text));
        if (oldWidgetController == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  String _formatValue(String value) => value.format(
    precision: widget.precision,
    separatorVariant: widget.separatorVariant,
  );

  String get _fallbackValue => widget.min.toString();

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = _formatValue(value ?? _fallbackValue);
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = _formatValue(
        widget.initialValue ?? _fallbackValue,
      );
    });
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
