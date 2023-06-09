import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusSelectInputFormField<T> extends FormField<T> {
  OptimusSelectInputFormField({
    super.key,
    required T super.initialValue,
    super.onSaved,
    super.validator,
    super.enabled,
    super.autovalidateMode,
    String? label,
    String placeholder = '',
    required ValueBuilder<T> builder,
    required List<OptimusDropdownTile<T>> items,
    ValueChanged<T>? onChanged,
  }) : super(
          builder: (FormFieldState<T> field) => OptimusSelectInput<T>(
            label: label,
            placeholder: placeholder,
            value: field.value,
            error: field.errorText,
            builder: builder,
            items: items,
            isEnabled: enabled,
            onChanged: (v) {
              field.didChange(v);
              onChanged?.call(v);
            },
          ),
        );
}
