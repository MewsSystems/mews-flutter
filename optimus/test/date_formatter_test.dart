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
      format: 'DD-MM--/@YYYY',
      oldValue: const TextEditingValue(
        text: '01-MM--/@YYYY',
        selection: TextSelection.collapsed(offset: 5),
      ),
      newValue: const TextEditingValue(
        text: '01-MM2--/@YYYY',
        selection: TextSelection.collapsed(offset: 6),
      ),
      expected: const TextEditingValue(
        text: '01-MM--/@2YYY',
        selection: TextSelection.collapsed(offset: 10),
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
