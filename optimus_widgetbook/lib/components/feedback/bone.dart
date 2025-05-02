import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final GlobalKey _circleKey = GlobalKey();
final GlobalKey _squareKey = GlobalKey();
final GlobalKey _textKey = GlobalKey();

@widgetbook.UseCase(
  name: 'Square',
  type: OptimusBoneSquare,
  path: '[Feedback]/Bone',
)
Widget createSquareStyle(BuildContext context) {
  final k = context.knobs;
  final isLoading = k.boolean(label: 'Loading', initialValue: true);
  final width = k.double.slider(label: 'Width', initialValue: 80, max: 200);
  final height = k.double.slider(label: 'Height', initialValue: 80, max: 200);

  return OptimusSkeleton(
    key: _squareKey,
    child: OptimusBoneSquare(
      isLoading: isLoading,
      width: width,
      height: height,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Circle',
  type: OptimusBoneCircle,
  path: '[Feedback]/Bone',
)
Widget createCircleStyle(BuildContext context) {
  final k = context.knobs;
  final isLoading = k.boolean(label: 'Loading', initialValue: true);
  final size = k.double.slider(label: 'Size', initialValue: 80, max: 200);

  return OptimusSkeleton(
    key: _circleKey,
    child: OptimusBoneCircle(isLoading: isLoading, size: size),
  );
}

@widgetbook.UseCase(
  name: 'Text',
  type: OptimusBoneText,
  path: '[Feedback]/Bone',
)
Widget createTextBone(BuildContext context) {
  final k = context.knobs;
  final isLoading = k.boolean(label: 'Loading', initialValue: true);
  final width = k.double.slider(label: 'Width', initialValue: 200, max: 400);
  final height = k.double.slider(label: 'Height', initialValue: 20, max: 100);

  return OptimusSkeleton(
    key: _textKey,
    child: OptimusBoneText(isLoading: isLoading, width: width, height: height),
  );
}
