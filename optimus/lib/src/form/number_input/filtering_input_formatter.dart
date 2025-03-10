import 'package:flutter/services.dart';
import 'package:optimus/src/form/number_input/number_input.dart';

class NumberInputFilteringTextInputFormatter extends TextInputFormatter {
  const NumberInputFilteringTextInputFormatter({
    required this.precision,
    required this.separatorVariant,
  });

  final int precision;
  final OptimusNumberSeparatorVariant separatorVariant;

  RegExp get _pattern {
    final decimalSeparator = RegExp.escape(separatorVariant.decimalSeparator);

    return RegExp(
      precision > 0
          ? r'^-?\d*(' +
              decimalSeparator +
              r'\d{0,' +
              precision.toString() +
              r'})?$'
          : r'^-?\d*$',
    );
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) => _pattern.hasMatch(newValue.text) ? newValue : oldValue;
}
