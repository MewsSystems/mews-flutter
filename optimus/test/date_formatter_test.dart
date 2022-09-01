import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimus/src/form/date_formatter.dart';

typedef FormatEditUpdateCallback = void Function(
  TextEditingValue,
  TextEditingValue,
);

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

class TestFormatter extends DateFormatter {
  TestFormatter({
    String? mask,
    String? placeholder,
    List<int>? userInput,
    VoidCallback? onUserInputChanged,
    RegExp? allowedDigits,
    required this.onFormatEditUpdate,
  }) : super(
          mask: mask ?? '##-##-####',
          placeholder: placeholder ?? 'DD-MM-YYYY',
          userInput: userInput ?? [],
          onUserInputChanged: onUserInputChanged ?? () {},
          allowedDigits: allowedDigits ?? RegExp(r'[0-9]'),
        );

  FormatEditUpdateCallback onFormatEditUpdate;
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    newValue = super.formatEditUpdate(oldValue, newValue);
    onFormatEditUpdate(oldValue, newValue);

    return newValue;
  }
}

void main() {
  late TextEditingValue actualOldValue;
  late TextEditingValue actualNewValue;
  void callBack(TextEditingValue oldValue, TextEditingValue newValue) {
    actualOldValue = oldValue;
    actualNewValue = newValue;
  }

  group('Adding first valid value', () {
    testWidgets('Adding valid input', (tester) async {
      final userInput = <int>[];

      await tester.pumpWidget(
        boilerplate(
          child: TextField(
            inputFormatters: [
              TestFormatter(userInput: userInput, onFormatEditUpdate: callBack)
            ],
          ),
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '1',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );

      await tester.pump();

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '1D-MM-YYYY',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );

      expect(userInput, [0]);
    });

    testWidgets('Adding value, when mask starts with placeholder',
        (tester) async {
      final userInput = <int>[];

      await tester.pumpWidget(
        boilerplate(
          child: TextField(
            inputFormatters: [
              TestFormatter(
                mask: '--##-##',
                placeholder: '--MM-YY',
                userInput: userInput,
                onFormatEditUpdate: callBack,
              )
            ],
          ),
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '1',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '--1M-YY',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      expect(userInput, [2, 0, 1]);
    });

    testWidgets('Adding valid input will add mask before it', (tester) async {
      final userInput = <int>[0, 1];
      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: '01-MM-YYYY',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      await tester.pumpWidget(
        boilerplate(
          child: TextField(
            controller: controller,
            inputFormatters: [
              TestFormatter(
                userInput: userInput,
                onFormatEditUpdate: callBack,
              )
            ],
          ),
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '01-1MM-YYYY',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '01-MM-YYYY',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '01-1M-YYYY',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      expect(userInput, [0, 1, 3, 2]);
    });

    testWidgets('Adding valid input will add whole mask before it',
        (tester) async {
      final userInput = <int>[0, 1];
      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: '01-MM--/@YYYY',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );

      await tester.pumpWidget(
        boilerplate(
          child: TextField(
            controller: controller,
            inputFormatters: [
              TestFormatter(
                mask: '##-##--/@####',
                placeholder: 'DD-MM-#/@YYYY',
                userInput: userInput,
                onFormatEditUpdate: callBack,
              )
            ],
          ),
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '01-MM2--/@YYYY',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '01-MM--/@YYYY',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '01-MM--/@2YYY',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      expect(userInput, [0, 1, 5, 6, 7, 8, 9]);
    });

    testWidgets('Adding valid input will add only mask before it',
        (tester) async {
      final userInput = <int>[0, 1];
      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: '01-MM-YYYY',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      await tester.pumpWidget(
        boilerplate(
          child: TextField(
            controller: controller,
            inputFormatters: [
              TestFormatter(
                userInput: userInput,
                onFormatEditUpdate: callBack,
              )
            ],
          ),
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '01-MM-2YYYY',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '01-MM-YYYY',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '01-MM-2YYY',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      expect(userInput, [0, 1, 6, 5]);
    });

    testWidgets('Adding valid input when the value is complete',
        (tester) async {
      final TextEditingController controller =
          TextEditingController(text: '01-01-2020');

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '01-01-20201',
          selection: TextSelection.collapsed(offset: 11),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '01-01-2020',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '01-01-2020',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });

    testWidgets(
        'Adding valid input inside the field when the value is complete',
        (tester) async {
      final userInput = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

      final TextEditingController controller =
          TextEditingController(text: '01-01-2020');

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: userInput,
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '01-061-2020',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '01-01-2020',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '01-01-2020',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      expect(userInput, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    });

    testWidgets('Adding valid input inside the field ', (tester) async {
      final userInput = <int>[6];

      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: 'DD-MM-1YYY',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: userInput,
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: 'DD-MM-12YYY',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: 'DD-MM-1YYY',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: 'DD-MM-12YY',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );

      expect(userInput, [6, 7]);
    });

    testWidgets('Jumping over mask symbols, after the valid input',
        (tester) async {
      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );

      final userInput = <int>[];

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: userInput,
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: 'D2D-MM-YYYY',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: 'D2-MM-YYYY',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      expect(userInput, [1]);
    });

    testWidgets('Typing outside the pattern', (tester) async {
      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: [],
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: 'DD-MM-YYYY6',
          selection: TextSelection.collapsed(offset: 11),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );
    });
    testWidgets('Entering valid value before at the mask place',
        (tester) async {
      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: [],
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: 'DD2-MM-YYYY',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: 'DD-MM-YYYY',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: 'DD-2M-YYYY',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });
  });

  group('Adding invalid value', () {
    testWidgets('Adding invalid input', (tester) async {
      await tester.pumpWidget(
        boilerplate(
          child: TextField(
            inputFormatters: [TestFormatter(onFormatEditUpdate: callBack)],
          ),
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: 'A',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        ),
      );
    });

    testWidgets('Adding invalid input when the value is complete',
        (tester) async {
      final TextEditingController controller =
          TextEditingController(text: '01-01-2020');

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '01-01-2020A',
          selection: TextSelection.collapsed(offset: 11),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '01-01-2020',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      expect(
        actualNewValue,
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
          inputFormatters: [TestFormatter(onFormatEditUpdate: (p0, p1) {})],
        ),
      ),
    );

    expect(find.text('01-01-2020'), findsOneWidget);
  });

  group('Removing', () {
    testWidgets('Removing user inputted value', (tester) async {
      final userInput = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: '17-06-2017',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: userInput,
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '17-06-201',
          selection: TextSelection.collapsed(offset: 9),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '17-06-2017',
          selection: TextSelection.collapsed(offset: 10),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '17-06-201Y',
          selection: TextSelection.collapsed(offset: 9),
        ),
      );

      expect(userInput, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
    });

    testWidgets('Removing placeholder value', (tester) async {
      final userInput = <int>[5, 6, 7, 8, 9];

      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: 'DD-MM-2017',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: userInput,
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: 'DD-M-2017',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: 'DD-MM-2017',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: 'DD-MM-2017',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      expect(userInput, [5, 6, 7, 8, 9]);
    });
    testWidgets('Removing; next char is valid', (tester) async {
      final userInput = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: '17-06-2017',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: userInput,
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '17-062017',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '17-06-2017',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '17-0M-2017',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      expect(userInput, [0, 1, 2, 3, 5, 6, 7, 8, 9]);
    });

    testWidgets('Removing; next char is placeholder', (tester) async {
      final userInput = <int>[0, 1, 2, 3, 5, 6, 7, 8, 9];

      final TextEditingController controller = TextEditingController.fromValue(
        const TextEditingValue(
          text: '17-0M-2017',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      final testTextField = TextField(
        controller: controller,
        inputFormatters: [
          TestFormatter(
            userInput: userInput,
            onFormatEditUpdate: callBack,
          )
        ],
      );

      await tester.pumpWidget(
        boilerplate(
          child: testTextField,
        ),
      );

      await tester.showKeyboard(find.byType(TextField));

      tester.testTextInput.updateEditingValue(
        const TextEditingValue(
          text: '17-0M2017',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );

      expect(
        actualOldValue,
        const TextEditingValue(
          text: '17-0M-2017',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      expect(
        actualNewValue,
        const TextEditingValue(
          text: '17-0M-2017',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      expect(userInput, [0, 1, 2, 3, 5, 6, 7, 8, 9]);
    });
  });
}
