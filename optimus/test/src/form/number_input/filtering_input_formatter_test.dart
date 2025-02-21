import 'package:flutter_test/flutter_test.dart';
import 'package:optimus/src/form/number_input/filtering_input_formatter.dart';
import 'package:optimus/src/form/number_input/number_input.dart';

void main() {
  group('NumberInputAllowFormatter', () {
    test('allows valid number input with comma and stop separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.commaAndStop;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1234.56');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1234.56');
    });

    test('disallows invalid number input with comma and stop separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.commaAndStop;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue(text: '1234.56');
      const newValue = TextEditingValue(text: '1234.567');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1234.56');
    });

    test('allows valid negative number input with comma and stop separators',
        () {
      const separatorVariant = OptimusNumberSeparatorVariant.commaAndStop;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '-1234.56');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '-1234.56');
    });

    test(
        'disallows invalid negative number input with comma and stop separators',
        () {
      const separatorVariant = OptimusNumberSeparatorVariant.commaAndStop;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue(text: '-1234.56');
      const newValue = TextEditingValue(text: '-1234.567');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '-1234.56');
    });

    test('allows valid number input with stop and comma separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.stopAndComma;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1234,56');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1234,56');
    });

    test('disallows invalid number input with stop and comma separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.stopAndComma;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue(text: '1234,56');
      const newValue = TextEditingValue(text: '1234,567');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1234,56');
    });

    test('allows valid number input with space and comma separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.spaceAndComma;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1234 56');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1234 56');
    });

    test('disallows invalid number input with space and comma separators', () {
      const separatorVariant = OptimusNumberSeparatorVariant.spaceAndComma;
      final formatter = NumberInputFilteringTextInputFormatter(
        precision: 2,
        separatorVariant: separatorVariant,
      );

      const oldValue = TextEditingValue(text: '1234 56');
      const newValue = TextEditingValue(text: '1234 567');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '1234 56');
    });
  });
}
