import 'package:flutter_test/flutter_test.dart';
import 'package:optimus/src/form/number_formatter.dart';
import 'package:optimus/src/form/number_input.dart';

void main() {
  group('Number Formatter', () {
    test('formats number with comma and stop separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.commaAndStop;
      const input = '1234567.89';
      const expectedOutput = '1,234,567.89';

      final formatted = input.format(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });

    test('formats number with stop and comma separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.stopAndComma;
      const input = '1234567.89';
      const expectedOutput = '1.234.567,89';

      final formatted = input.format(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });

    test('formats number with space and comma separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.noneAndComma;
      const input = '1234567.89';
      const expectedOutput = '1 234 567,89';

      final formatted = input.format(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });

    test('formats number with space and stop separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.noneAndStop;
      const input = '1234567.89';
      const expectedOutput = '1 234 567.89';

      final formatted = input.format(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });

    test('formats number with empty and comma separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.emptyAndComma;
      const input = '1234567.89';
      const expectedOutput = '1234567,89';

      final formatted = input.format(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });

    test('formats number with empty and stop separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.emptyAndStop;
      const input = '1234567.89';
      const expectedOutput = '1234567.89';

      final formatted = input.format(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });

    test('formats negative number with comma and stop separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.commaAndStop;
      const input = '-1234567.89';
      const expectedOutput = '-1,234,567.89';

      final formatted = input.format(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });

    test('formats number with different precision', () {
      const separatorVariant = OptimusNumberSeparatorVariant.commaAndStop;
      const input = '1234567.89';
      const expectedOutput = '1,234,567.8900';

      final formatted = input.format(
        precision: 4,
        separatorVariant: separatorVariant,
      );

      expect(formatted, expectedOutput);
    });
  });
}
