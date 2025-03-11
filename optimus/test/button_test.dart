import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimus/optimus.dart';

void main() {
  testWidgets('OptimusButton has text', (tester) async {
    const widget = MaterialApp(home: OptimusButton(child: Text('Test me')));
    await tester.pumpWidget(widget);
    final textFinder = find.text('Test me');

    expect(textFinder, findsOneWidget);
  });
}
