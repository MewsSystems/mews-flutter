import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusCheckBoxFormField extends StatelessWidget {
  const OptimusCheckBoxFormField({
    super.key,
    required this.label,
    this.onSaved,
    this.initialValue = false,
    this.isEnabled = true,
    this.size = OptimusCheckboxSize.large,
    this.validator,
    this.autovalidateMode,
  });

  final Widget label;
  final ValueChanged<bool?>? onSaved;
  // ignore: prefer-boolean-prefixes, valid naming
  final bool initialValue;
  final bool isEnabled;
  final OptimusCheckboxSize size;
  final FormFieldValidator<bool>? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) => FormField<bool>(
    initialValue: initialValue,
    onSaved: onSaved,
    enabled: isEnabled,
    validator: validator,
    autovalidateMode: autovalidateMode,
    builder:
        (state) => OptimusCheckbox(
          label: label,
          size: size,
          isEnabled: isEnabled,
          isChecked: state.value ?? initialValue,
          error: state.errorText,
          onChanged: state.didChange,
        ),
  );
}
