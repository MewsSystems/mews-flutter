import 'package:optimus/src/form/number_input/number_input.dart';

extension NumberFormatter on String {
  String format({
    required int precision,
    required OptimusNumberSeparatorVariant separatorVariant,
  }) {
    final isNegative = startsWith('-');
    final cleared = replaceAll(RegExp(r'[^\d.]'), '');

    if (cleared.isEmpty) return isNegative ? '-' : '';

    final fixedLength = num.parse(cleared).toStringAsFixed(precision);
    final parts = fixedLength.split('.');
    final wholePart = parts.first;
    final decimalPart = parts.length > 1 ? parts.last : '';

    final buffer = StringBuffer();
    if (isNegative) {
      buffer.write('-');
    }
    for (int i = 0; i < wholePart.length; i++) {
      if (i > 0 && (wholePart.length - i) % 3 == 0) {
        buffer.write(separatorVariant.groupSeparator);
      }
      buffer.write(wholePart[i]);
    }

    if (decimalPart.isNotEmpty) {
      buffer
        ..write(separatorVariant.decimalSeparator)
        ..write(decimalPart);
    }

    return buffer.toString();
  }
}
