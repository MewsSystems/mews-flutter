import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Skeleton', type: OptimusSkeleton, path: '[Feedback]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusSkeleton(
    isLoading: k.boolean(label: 'Loading', initialValue: true),
    child: const OptimusChip(child: Text('Skeleton')),
  );
}
