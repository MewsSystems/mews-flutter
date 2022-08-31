import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusDateInputFormField extends FormField<DateTime?> {
  OptimusDateInputFormField({
    Key? key,
    DateTime? initialValue,
    required DateFormat format,
    FormFieldSetter<DateTime?>? onSaved,
    FormFieldValidator<DateTime?>? validator,
    AutovalidateMode? autovalidateMode,
    TextInputType? keyboardType,
    bool isEnabled = true,
    ValueChanged<DateTime?>? onSubmitted,
    FocusNode? focusNode,
    String? label,
    bool hasBorders = true,
    bool isRequired = false,
    bool isClearAllEnabled = false,
    Key? inputKey,
    bool? showCursor,
    VoidCallback? onTap,
    TextAlign textAlign = TextAlign.start,
    TextCapitalization textCapitalization = TextCapitalization.none,
    Widget? caption,
    Widget? secondaryCaption,
    Brightness? keyboardAppearance,
    bool enableIMEPersonalizedLearning = false,
    bool enableSuggestions = true,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          enabled: isEnabled,
          builder: (FormFieldState<DateTime?> field) => OptimusDateInputField(
            onChanged: field.didChange,
            keyboardType: keyboardType,
            isEnabled: isEnabled,
            isClearAllEnabled: isClearAllEnabled,
            onSubmitted: onSubmitted,
            initialValue: initialValue,
            format: format,
            focusNode: focusNode,
            label: label,
            error: field.errorText,
            hasBorders: hasBorders,
            isRequired: isRequired,
            showCursor: showCursor,
            onTap: onTap,
            inputKey: inputKey,
            textAlign: textAlign,
            textCapitalization: textCapitalization,
            caption: caption,
            secondaryCaption: secondaryCaption,
            keyboardAppearance: keyboardAppearance,
            enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
            enableSuggestions: enableSuggestions,
          ),
        );

  @override
  FormFieldState<DateTime?> createState() => _DateInputFormFieldState();
}

class _DateInputFormFieldState extends FormFieldState<DateTime?> {
  @override
  OptimusDateInputFormField get widget =>
      super.widget as OptimusDateInputFormField;
}
