import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

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
