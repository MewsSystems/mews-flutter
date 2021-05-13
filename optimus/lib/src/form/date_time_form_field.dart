import 'package:flutter/widgets.dart';
import 'package:optimus/src/date_time_field.dart';

class OptimusDateTimeFormField extends FormField<DateTime> {
  OptimusDateTimeFormField({
    Key? key,
    required DateTime initialValue,
    required DateTimeFormatter formatDateTime,
    required FormFieldSetter<DateTime> onSaved,
    FormFieldValidator<DateTime>? validator,
    AutovalidateMode? autovalidateMode,
    String? label,
    DateTime? minDate,
    DateTime? maxDate,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<DateTime> field) => OptimusDateTimeField(
            value: field.value,
            label: label,
            onChanged: (v) => field.didChange(v),
            minDate: minDate,
            maxDate: maxDate,
            error: field.hasError ? validator?.call(field.value) : null,
            formatDateTime: formatDateTime,
          ),
        );
}
