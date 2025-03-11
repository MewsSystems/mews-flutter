import 'package:flutter/widgets.dart';
import 'package:optimus/src/date_time_field.dart';

class OptimusDateTimeFormField extends FormField<DateTime> {
  OptimusDateTimeFormField({
    super.key,
    required DateTime super.initialValue,
    required DateTimeFormatter formatDateTime,
    required FormFieldSetter<DateTime> super.onSaved,
    super.validator,
    super.autovalidateMode,
    String? label,
    DateTime? minDate,
    DateTime? maxDate,
  }) : super(
         builder:
             (FormFieldState<DateTime> field) => OptimusDateTimeField(
               value: field.value,
               label: label,
               onChanged: (v) => field.didChange(v),
               minDate: minDate,
               maxDate: maxDate,
               error: field.errorText,
               formatDateTime: formatDateTime,
             ),
       );
}
