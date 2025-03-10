import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusDateInputFormField extends FormField<DateTime?> {
  OptimusDateInputFormField({
    super.key,
    DateTime? value,
    required DateFormat format,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
    bool isEnabled = true,
    ValueChanged<DateTime?>? onSubmitted,
    FocusNode? focusNode,
    String? label,
    bool isRequired = false,
    bool isClearAllEnabled = false,
    VoidCallback? onTap,
    Widget? caption,
    Widget? helperMessage,
  }) : super(
         enabled: isEnabled,
         initialValue: value,
         builder:
             (FormFieldState<DateTime?> field) => OptimusDateInputField(
               onChanged: field.didChange,
               isEnabled: isEnabled,
               isClearAllEnabled: isClearAllEnabled,
               onSubmitted: onSubmitted,
               value: value,
               format: format,
               focusNode: focusNode,
               label: label,
               error: field.errorText,
               isRequired: isRequired,
               onTap: onTap,
               caption: caption,
               helperMessage: helperMessage,
             ),
       );

  @override
  FormFieldState<DateTime?> createState() => _DateInputFormFieldState();
}

class _DateInputFormFieldState extends FormFieldState<DateTime?> {
  @override
  OptimusDateInputFormField get widget =>
      // ignore: avoid-type-casts, no need to check, can't be anything else
      super.widget as OptimusDateInputFormField;
}
