import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimus/src/form/date_formatter.dart';

Widget boilerplate({required Widget child}) => MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(size: Size(800.0, 600.0)),
          child: Center(
            child: Material(
              child: child,
            ),
          ),
        ),
      ),
    );

void main() {
  group('Adding first valid value', () {
    test('Adding valid input', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      const newValue = TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '1D-MM-YYYY',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );
    });

    test('Adding value, when mask starts with placeholder', () {
      final formatter = DateFormatter(
        placeholder: '--MM-YY',
      );

      const oldValue = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      const newValue = TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '--1M-YY',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );
    });

    test('Adding valid input will add mask before it', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue(
        text: '01-MM-YYYY',
        selection: TextSelection.collapsed(offset: 3),
      );

      const newValue = TextEditingValue(
        text: '01-1MM-YYYY',
        selection: TextSelection.collapsed(offset: 4),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '01-1M-YYYY',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });

    test('Adding valid input will add whole mask before it', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM--/@YYYY',
      );

      const oldValue = TextEditingValue(
        text: '01-MM--/@YYYY',
        selection: TextSelection.collapsed(offset: 5),
      );

      const newValue = TextEditingValue(
        text: '01-MM2--/@YYYY',
        selection: TextSelection.collapsed(offset: 6),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '01-MM--/@2YYY',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });

    test('Adding valid input will add only mask before it', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue(
        text: '01-MM-YYYY',
        selection: TextSelection.collapsed(offset: 6),
      );

      const newValue = TextEditingValue(
        text: '01-MM-2YYYY',
        selection: TextSelection.collapsed(offset: 7),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '01-MM-2YYY',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );
    });

    test('Adding valid input when the value is complete', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue(
        text: '01-01-2021',
        selection: TextSelection.collapsed(offset: 10),
      );

      const newValue = TextEditingValue(
        text: '01-01-20211',
        selection: TextSelection.collapsed(offset: 11),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '01-01-2021',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });

    test('Adding valid input inside the field when the value is complete', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue(
        text: '01-01-2020',
        selection: TextSelection.collapsed(offset: 10),
      );

      const newValue = TextEditingValue(
        text: '01-061-2020',
        selection: TextSelection.collapsed(offset: 4),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '01-01-2020',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });

    test('Adding valid input inside the field ', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue(
        text: 'DD-MM-1YYY',
        selection: TextSelection.collapsed(offset: 7),
      );

      const newValue = TextEditingValue(
        text: 'DD-MM-12YYY',
        selection: TextSelection.collapsed(offset: 8),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: 'DD-MM-12YY',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );
    });

    test('Jumping over mask symbols, after the valid input', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 1),
      );

      const newValue = TextEditingValue(
        text: 'D2D-MM-YYYY',
        selection: TextSelection.collapsed(offset: 2),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: 'D2-MM-YYYY',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );
    });

    test('Typing outside the pattern', () {
      const oldValue = TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 10),
      );

      final formatter = DateFormatter(placeholder: 'DD-MM-YYYY');

      const newValue = TextEditingValue(
        text: 'DD-MM-YYYY6',
        selection: TextSelection.collapsed(offset: 11),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });
    test('Entering valid value before at the mask place', () {
      const oldValue = TextEditingValue(
        text: 'DD-MM-YYYY',
        selection: TextSelection.collapsed(offset: 2),
      );

      final formatter = DateFormatter(placeholder: 'DD-MM-YYYY');

      const newValue = TextEditingValue(
        text: 'DD2-MM-YYYY',
        selection: TextSelection.collapsed(offset: 3),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: 'DD-2M-YYYY',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });
  });

  group('Adding invalid value', () {
    test('Adding invalid input', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const oldValue = TextEditingValue.empty;

      const newValue = TextEditingValue(
        text: 'A',
        selection: TextSelection.collapsed(offset: 1),
      );
      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        TextEditingValue.empty,
      );
    });

    test('Adding invalid input when the value is complete', () {
      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );
      const oldValue = TextEditingValue(
        text: '01-01-2020',
        selection: TextSelection.collapsed(offset: 10),
      );

      const newValue = TextEditingValue(
        text: '01-01-2020A',
        selection: TextSelection.collapsed(offset: 11),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);
      expect(
        actual,
        const TextEditingValue(
          text: '01-01-2020',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });
  });

  testWidgets('Starting with initial value', (tester) async {
    final TextEditingController controller =
        TextEditingController(text: '01-01-2020');

    await tester.pumpWidget(
      boilerplate(
        child: TextField(
          controller: controller,
          inputFormatters: [DateFormatter(placeholder: 'DD-MM-YYYY')],
        ),
      ),
    );

    expect(find.text('01-01-2020'), findsOneWidget);
  });

  group('Removing', () {
    test('Removing user inputted value', () {
      const oldValue = TextEditingValue(
        text: '17-06-2017',
        selection: TextSelection.collapsed(offset: 10),
      );
      final formatter = DateFormatter(placeholder: 'DD-MM-YYYY');

      const newValue = TextEditingValue(
        text: '17-06-201',
        selection: TextSelection.collapsed(offset: 9),
      );
      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '17-06-201Y',
          selection: TextSelection.collapsed(offset: 9),
        ),
      );
    });

    test('Removing placeholder value', () {
      const oldValue = TextEditingValue(
        text: 'DD-MM-2017',
        selection: TextSelection.collapsed(offset: 5),
      );

      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const newValue = TextEditingValue(
        text: 'DD-M-2017',
        selection: TextSelection.collapsed(offset: 4),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);
      expect(
        actual,
        const TextEditingValue(
          text: 'DD-MM-2017',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });
    test('Removing; next char is valid', () {
      const oldValue = TextEditingValue(
        text: '17-06-2017',
        selection: TextSelection.collapsed(offset: 6),
      );
      final formatter = DateFormatter(placeholder: 'DD-MM-YYYY');

      const newValue = TextEditingValue(
        text: '17-062017',
        selection: TextSelection.collapsed(offset: 5),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '17-0M-2017',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });

    test('Removing; next char is placeholder', () {
      const oldValue = TextEditingValue(
        text: '17-0M-2017',
        selection: TextSelection.collapsed(offset: 6),
      );

      final formatter = DateFormatter(
        placeholder: 'DD-MM-YYYY',
      );

      const newValue = TextEditingValue(
        text: '17-0M2017',
        selection: TextSelection.collapsed(offset: 5),
      );

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(
        actual,
        const TextEditingValue(
          text: '17-0M-2017',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });
  });
}
