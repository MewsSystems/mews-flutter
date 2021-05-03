import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusCheckBoxFormField extends FormField<bool> {
  OptimusCheckBoxFormField({
    Key? key,
    required Widget label,
    bool isRequired = false,
    bool initialValue = false,
    ValueChanged<bool?>? onSaved,
    bool isEnabled = true,
    OptimusCheckboxSize size = OptimusCheckboxSize.large,
    FormFieldValidator<bool>? validator,
    AutovalidateMode? autovalidateMode,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          enabled: isEnabled,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<bool> field) => OptimusCheckbox(
            label: label,
            isRequired: isRequired,
            size: size,
            isEnabled: isEnabled,
            isChecked: field.value ?? initialValue,
            error: field.errorText,
            onChanged: field.didChange,
          ),
        );
}
