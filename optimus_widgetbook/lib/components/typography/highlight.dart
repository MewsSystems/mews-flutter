import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Highlight Small',
  type: OptimusHighlightSmall,
  path: '[Typography]/Highlight',
)
Widget createHighLightSmall(BuildContext context) => OptimusHighlightSmall(
      child: Text(
        context.knobs.string(label: 'Text', initialValue: 'Highlight Small'),
      ),
    );

@widgetbook.UseCase(
  name: 'Highlight Medium',
  type: OptimusHighlightMedium,
  path: '[Typography]/Highlight',
)
Widget createHighlightMedium(BuildContext context) => OptimusHighlightMedium(
      child: Text(
        context.knobs.string(label: 'Text', initialValue: 'Highlight Medium'),
      ),
    );

@widgetbook.UseCase(
  name: 'Highlight Large',
  type: OptimusHighlightLarge,
  path: '[Typography]/Highlight',
)
Widget createHighlightLarge(BuildContext context) => OptimusHighlightLarge(
      child: Text(
        context.knobs.string(label: 'Text', initialValue: 'Highlight Large'),
      ),
    );
