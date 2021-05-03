import 'package:flutter/widgets.dart';
import 'package:optimus/src/search/dropdown_tile.dart';
import 'package:optimus/src/select.dart';

class OptimusSelectFormField<T> extends FormField<T> {
  OptimusSelectFormField({
    Key? key,
    required T initialValue,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? label,
    String placeholder = '',
    required CurrentValueBuilder<T> builder,
    required List<OptimusDropdownTile<T>> items,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<T> field) => OptimusSelect<T>(
            label: label,
            placeholder: placeholder,
            value: field.value,
            error: field.errorText,
            builder: builder,
            items: items,
            isEnabled: enabled,
            onItemSelected: field.didChange,
          ),
        );
}
