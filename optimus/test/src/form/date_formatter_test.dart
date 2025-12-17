import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optimus/src/form/date_formatter.dart';

@isTest
void testFormat({
  String format = 'DD-MM-YYYY',
  String? description,
  TextEditingValue oldValue = const TextEditingValue(
    text: '',
    selection: TextSelection.collapsed(offset: 0),
  ),
  required TextEditingValue newValue,
  required TextEditingValue expected,
}) {
  test(description ?? 'formats ${newValue.text} according to $format', () {
    final formatter = DateFormatter(placeholder: format);

    expect(formatter.formatEditUpdate(oldValue, newValue), expected);
  });
}

void main() {
  group('Valid input', () {
    testFormat(
      description: 'Initial valid input is accepted',
      newValue: const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      ),
      expected: const TextEditingValue(
        text: '1D-MM-YYYY',
        selection: TextSelection.collapsed(offset: 1),
      ),
    );

    testFormat(
      description: 'Initial valid input skipped the mask',
      format: '--MM-YY',
      newValue: const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      ),
      expected: const TextEditingValue(
        text: '--1M-YY',
        selection: TextSelection.collapsed(offset: 3),
      ),
    );

    testFormat(
      oldValue: const TextEditingValue(
        text: '01-MM-YYYY',
        selection: TextSelection.collapsed(offset: 3),
      ),
      newValue: const TextEditingValue(
        text: '01-1MM-YYYY',
        selection: TextSelection.collapsed(offset: 4),
      ),
      expected: const TextEditingValue(
        text: '01-1M-YYYY',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );

    testFormat(
      description: 'Valid input inside skipped the mask',
      format: 'DD-MM-YYYY',
      oldValue: const TextEditingValue(
        text: '01-MM-YYYY',
        selection: TextSelection.collapsed(offset: 5),
      ),
      newValue: const TextEditingValue(
        text: '01-MM2-YYYY',
        selection: TextSelection.collapsed(offset: 6),
      ),
      expected: const TextEditingValue(
        text: '01-MM-2YYY',
        selection: TextSelection.collapsed(offset: 7),
      ),
    );

    testFormat(
      oldValue: const TextEditingValue(
        text: '01-MM-YYYY',
        selection: TextSelection.collapsed(offset: 6),
      ),
      newValue: const TextEditingValue(
        text: '01-MM-2YYYY',
        selection: TextSelection.collapsed(offset: 7),
      ),
      expected: const TextEditingValue(
        text: '01-MM-2YYY',
        selection: TextSelection.collapsed(offset: 7),
      ),
    );

    testFormat(
      oldValue: const TextEditingValue(
        text: 'DD-MM-1YYY',
        selection: TextSelection.collapsed(offset: 7),
      ),
      newValue: const TextEditingValue(
        text: 'DD-MM-12YYY',
        selection: TextSelection.collapsed(offset: 8),
      ),
      expected: const TextEditingValue(
        text: 'DD-MM-12YY',
        selection: TextSelection.collapsed(offset: 8),
      ),
    );

    testFormat(
      description: 'Selection position skipped to next valid',
      oldValue: const TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 1),
      ),
      newValue: const TextEditingValue(
        text: 'D2D-MM-YYYY',
        selection: TextSelection.collapsed(offset: 2),
      ),
      expected: const TextEditingValue(
        text: 'D2-MM-YYYY',
        selection: TextSelection.collapsed(offset: 3),
      ),
    );

    testFormat(
      description: 'Valid input before the mask is transferred over the mask',
      oldValue: const TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 2),
      ),
      newValue: const TextEditingValue(
        text: 'DD2-MM-YYYY',
        selection: TextSelection.collapsed(offset: 3),
      ),
      expected: const TextEditingValue(
        text: 'DD-2M-YYYY',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );
  });

  group('Invalid input', () {
    testFormat(
      description: 'Valid input is ignored if position if out of range',
      oldValue: const TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 10),
      ),
      newValue: const TextEditingValue(
        text: 'DD-MM-YYYY6',
        selection: TextSelection.collapsed(offset: 11),
      ),
      expected: const TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Valid input is ignored if field is full',
      oldValue: const TextEditingValue(
        text: '01-01-2021',
        selection: TextSelection.collapsed(offset: 10),
      ),
      newValue: const TextEditingValue(
        text: '01-01-20211',
        selection: TextSelection.collapsed(offset: 11),
      ),
      expected: const TextEditingValue(
        text: '01-01-2021',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Valid input is ignored if field is full',
      oldValue: const TextEditingValue(
        text: '01-01-2020',
        selection: TextSelection.collapsed(offset: 10),
      ),
      newValue: const TextEditingValue(
        text: '01-061-2020',
        selection: TextSelection.collapsed(offset: 4),
      ),
      expected: const TextEditingValue(
        text: '01-01-2020',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Initial invalid input is ignored',
      newValue: const TextEditingValue(
        text: 'A',
        selection: TextSelection.collapsed(offset: 1),
      ),
      expected: const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      ),
    );

    testFormat(
      description: 'Invalid input outside the mask is ignored',
      oldValue: const TextEditingValue(
        text: '01-01-2020',
        selection: TextSelection.collapsed(offset: 10),
      ),
      newValue: const TextEditingValue(
        text: '01-01-2020A',
        selection: TextSelection.collapsed(offset: 11),
      ),
      expected: const TextEditingValue(
        text: '01-01-2020',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Invalid input inside the field is ignored',
      oldValue: const TextEditingValue(
        text: '01-MM-YYYY',
        selection: TextSelection.collapsed(offset: 3),
      ),
      newValue: const TextEditingValue(
        text: '01-JMM-YYYY',
        selection: TextSelection.collapsed(offset: 4),
      ),
      expected: const TextEditingValue(
        text: '01-MM-YYYY',
        selection: TextSelection.collapsed(offset: 3),
      ),
    );
  });

  group('Inserting', () {
    testFormat(
      description: 'Inserting valid number inside the date on valid position',
      oldValue: const TextEditingValue(
        text: '17-06-2017',
        selection: TextSelection(baseOffset: 0, extentOffset: 2),
      ),
      newValue: const TextEditingValue(
        text: '2-06-2017',
        selection: TextSelection.collapsed(offset: 1),
      ),
      expected: const TextEditingValue(
        text: '2D-06-2017',
        selection: TextSelection.collapsed(offset: 1),
      ),
    );

    testFormat(
      description: 'Inserting valid number inside the date on invalid position',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 5, extentOffset: 6),
      ),
      newValue: const TextEditingValue(
        text: '31-0152023',
        selection: TextSelection.collapsed(offset: 6),
      ),
      expected: const TextEditingValue(
        text: '31-01-5202',
        selection: TextSelection.collapsed(offset: 7),
      ),
    );

    testFormat(
      description: 'Inserting invalid number inside the date on valid position',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 3, extentOffset: 5),
      ),
      newValue: const TextEditingValue(
        text: '31-v-2023',
        selection: TextSelection.collapsed(offset: 4),
      ),
      expected: const TextEditingValue(
        text: '31-MM-2023',
        selection: TextSelection.collapsed(offset: 3),
      ),
    );

    testFormat(
      description:
          'Inserting invalid number inside the date on invalid position',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 5, extentOffset: 6),
      ),
      newValue: const TextEditingValue(
        text: '31-01v2023',
        selection: TextSelection.collapsed(offset: 6),
      ),
      expected: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection.collapsed(offset: 5),
      ),
    );

    testFormat(
      description: 'Replacing whole field with valid date',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 10, extentOffset: 0),
      ),
      newValue: const TextEditingValue(
        text: '17-12-1234',
        selection: TextSelection.collapsed(offset: 10),
      ),
      expected: const TextEditingValue(
        text: '17-12-1234',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Replacing whole field with invalid date with numbers',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 0, extentOffset: 10),
      ),
      newValue: const TextEditingValue(
        text: 'v1-01-2023',
        selection: TextSelection.collapsed(offset: 10),
      ),
      expected: const TextEditingValue(
        text: '10-12-023Y',
        selection: TextSelection.collapsed(offset: 9),
      ),
    );

    testFormat(
      description: 'Replacing whole field with invalid date without numbers',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 0, extentOffset: 10),
      ),
      newValue: const TextEditingValue(
        text: 'loremIpsum',
        selection: TextSelection.collapsed(offset: 10),
      ),
      expected: const TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 0),
      ),
    );

    testFormat(
      description:
          'Replacing whole field with insufficient date (length does not match the pattern)',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 10, extentOffset: 0),
      ),
      newValue: const TextEditingValue(
        text: '2/12/2022',
        selection: TextSelection.collapsed(offset: 9),
      ),
      expected: const TextEditingValue(
        text: '21-22-022Y',
        selection: TextSelection.collapsed(offset: 9),
      ),
    );

    testFormat(
      description:
          'Replacing whole field with date that extend the pattern length',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 0, extentOffset: 10),
      ),
      newValue: const TextEditingValue(
        text: '07/1312/20722',
        selection: TextSelection.collapsed(offset: 13),
      ),
      expected: const TextEditingValue(
        text: '07-13-1220',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Inserting value that is greater than selected length',
      oldValue: const TextEditingValue(
        text: '31-01-9023',
        selection: TextSelection(baseOffset: 3, extentOffset: 5),
      ),
      newValue: const TextEditingValue(
        text: '31-20722-9023',
        selection: TextSelection.collapsed(offset: 8),
      ),
      expected: const TextEditingValue(
        text: '31-20-7229',
        selection: TextSelection.collapsed(offset: 9),
      ),
    );

    testFormat(
      description: 'Inserting value that length is lesser than selected length',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 6, extentOffset: 10),
      ),
      newValue: const TextEditingValue(
        text: '31-01-1',
        selection: TextSelection.collapsed(offset: 7),
      ),
      expected: const TextEditingValue(
        text: '31-01-1YYY',
        selection: TextSelection.collapsed(offset: 7),
      ),
    );

    testFormat(
      description: 'Inserting value that contains invalid char',
      oldValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection(baseOffset: 3, extentOffset: 5),
      ),
      newValue: const TextEditingValue(
        text: '31-1X-2023',
        selection: TextSelection.collapsed(offset: 5),
      ),
      expected: const TextEditingValue(
        text: '31-1M-2023',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );

    testFormat(
      description: 'Pasting valid value into the empty filed',
      oldValue: .empty,
      newValue: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection.collapsed(offset: 10),
      ),
      expected: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Pasting value with more chars than expected. Empty field',
      oldValue: .empty,
      newValue: const TextEditingValue(
        text: '31-01-20231234',
        selection: TextSelection.collapsed(offset: 14),
      ),
      expected: const TextEditingValue(
        text: '31-01-2023',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    testFormat(
      description: 'Pasting value with less chars than expected. Empty field.',
      oldValue: .empty,
      newValue: const TextEditingValue(
        text: '31-01-20',
        selection: TextSelection.collapsed(offset: 8),
      ),
      expected: const TextEditingValue(
        text: '31-01-20YY',
        selection: TextSelection.collapsed(offset: 8),
      ),
    );
  });

  group('Removing', () {
    testFormat(
      oldValue: const TextEditingValue(
        text: '17-06-2017',
        selection: TextSelection.collapsed(offset: 10),
      ),
      newValue: const TextEditingValue(
        text: '17-06-201',
        selection: TextSelection.collapsed(offset: 9),
      ),
      expected: const TextEditingValue(
        text: '17-06-201Y',
        selection: TextSelection.collapsed(offset: 9),
      ),
    );

    testFormat(
      oldValue: const TextEditingValue(
        text: 'DD-MM-2017',
        selection: TextSelection.collapsed(offset: 5),
      ),
      newValue: const TextEditingValue(
        text: 'DD-M-2017',
        selection: TextSelection.collapsed(offset: 4),
      ),
      expected: const TextEditingValue(
        text: 'DD-MM-2017',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );

    testFormat(
      description: 'Removing the mask symbol removed the previous input',
      oldValue: const TextEditingValue(
        text: '17-06-2017',
        selection: TextSelection.collapsed(offset: 6),
      ),
      newValue: const TextEditingValue(
        text: '17-062017',
        selection: TextSelection.collapsed(offset: 5),
      ),
      expected: const TextEditingValue(
        text: '17-0M-2017',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );

    testFormat(
      description: 'Removing the mask symbol jumped to next valid if possible',
      oldValue: const TextEditingValue(
        text: '17-0M-2017',
        selection: TextSelection.collapsed(offset: 6),
      ),
      newValue: const TextEditingValue(
        text: '17-0M2017',
        selection: TextSelection.collapsed(offset: 5),
      ),
      expected: const TextEditingValue(
        text: '17-0M-2017',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );
  });
}
