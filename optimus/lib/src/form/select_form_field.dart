import 'package:flutter/widgets.dart';
import 'package:optimus/src/dropdown/dropdown_tile.dart';
import 'package:optimus/src/select.dart';

@Deprecated('Use `OptimusSelectInputFormField` instead.')
class OptimusSelectFormField<T> extends FormField<T> {
  @Deprecated('Use `OptimusSelectInputFormField` instead.')
  OptimusSelectFormField({
    super.key,
    required T super.initialValue,
    super.onSaved,
    super.validator,
    super.enabled,
    super.autovalidateMode,
    String? label,
    String placeholder = '',
    required CurrentValueBuilder<T> builder,
    required List<OptimusDropdownTile<T>> items,
  }) : super(
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
