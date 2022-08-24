import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusInputFormField extends FormField<String> {
  OptimusInputFormField({
    Key? key,
    String? initialValue,
    this.controller,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    AutovalidateMode? autovalidateMode,
    String? placeholder,
    TextInputType? keyboardType,
    bool isPasswordField = false,
    bool isEnabled = true,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
    FocusNode? focusNode,
    String? label,
    int maxLines = 1,
    int? minLines,
    bool enableInteractiveSelection = true,
    bool autofocus = false,
    bool autocorrect = true,
    bool hasBorders = true,
    bool isRequired = false,
    Widget? leading,
    Widget? suffix,
    Widget? prefix,
    Widget? trailing,
    Key? inputKey,
    bool readOnly = false,
    bool? showCursor,
    VoidCallback? onTap,
    TextAlign textAlign = TextAlign.start,
    TextCapitalization textCapitalization = TextCapitalization.none,
    Widget? caption,
    Widget? secondaryCaption,
    Brightness? keyboardAppearance,
  })  : assert(
          initialValue == null || controller == null,
          'Provide either initial value or controller',
        ),
        super(
          key: key,
          initialValue: controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          enabled: isEnabled,
          builder: (FormFieldState<String> field) {
            final _InputFormFieldState state = field as _InputFormFieldState;

            return OptimusInputField(
              onChanged: field.didChange,
              placeholder: placeholder,
              keyboardType: keyboardType,
              isPasswordField: isPasswordField,
              isEnabled: isEnabled,
              textInputAction: textInputAction,
              onSubmitted: onSubmitted,
              focusNode: focusNode,
              label: label,
              maxLines: maxLines,
              minLines: minLines,
              controller: state._effectiveController,
              error: field.errorText,
              enableInteractiveSelection: enableInteractiveSelection,
              autofocus: autofocus,
              autocorrect: autocorrect,
              hasBorders: hasBorders,
              isRequired: isRequired,
              leading: leading,
              prefix: prefix,
              suffix: suffix,
              trailing: trailing,
              inputKey: inputKey,
              readOnly: readOnly,
              showCursor: showCursor,
              onTap: onTap,
              textAlign: textAlign,
              textCapitalization: textCapitalization,
              caption: caption,
              secondaryCaption: secondaryCaption,
              keyboardAppearance: keyboardAppearance,
            );
          },
        );

  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ??
      _controller!; // ignore: avoid-non-null-assertion, _controller would be initialized at this point

  @override
  OptimusInputFormField get widget => super.widget as OptimusInputFormField;

  @override
  void initState() {
    super.initState();
    final controller = widget.controller;
    if (controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(OptimusInputFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      final oldWidgetController = oldWidget.controller;
      final widgetController = widget.controller;

      if (oldWidgetController != null && widget.controller == null) {
        _controller = TextEditingController.fromValue(oldWidgetController.value);
      }
      if (widgetController != null) {
        setValue(widgetController.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue ?? '';
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
