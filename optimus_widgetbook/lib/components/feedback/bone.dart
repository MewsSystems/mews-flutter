import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final GlobalKey _cardKey = GlobalKey();
final GlobalKey _circleKey = GlobalKey();
final GlobalKey _textKey = GlobalKey();

@widgetbook.UseCase(name: 'Circle', type: OptimusBone, path: '[Feedback]')
Widget createCircleStyle(BuildContext context) {
  final k = context.knobs;
  final diameter = k.double.slider(
    label: 'Diameter',
    initialValue: 80,
    max: 200,
  );

  return OptimusSkeleton(
    key: _circleKey,
    child: OptimusBone.circle(diameter: diameter),
  );
}

@widgetbook.UseCase(name: 'Card', type: OptimusBone, path: '[Feedback]')
Widget createSquareStyle(BuildContext context) {
  final k = context.knobs;
  final width = k.double.slider(label: 'Width', initialValue: 80, max: 200);
  final height = k.double.slider(label: 'Height', initialValue: 80, max: 200);

  return OptimusSkeleton(
    key: _cardKey,
    child: OptimusBone.card(width: width, height: height),
  );
}

@widgetbook.UseCase(name: 'Text', type: OptimusBone, path: '[Feedback]')
Widget createTextBone(BuildContext context) {
  final k = context.knobs;
  final width = k.double.slider(label: 'Width', initialValue: 200, max: 400);
  final fontSize = k.double.slider(
    label: 'Font Size',
    initialValue: 12,
    max: 100,
  );

  return OptimusSkeleton(
    key: _textKey,
    child: OptimusBone.text(width: width, fontSize: fontSize),
  );
}
