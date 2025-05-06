import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Skeleton', type: OptimusSkeleton, path: '[Feedback]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final isLoading = k.boolean(label: 'Loading', initialValue: true);

  return OptimusSkeleton(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: context.tokens.spacing200,
      children: [
        OptimusBone(
          isLoading: isLoading,
          child: const OptimusAvatar(title: 'Avatar'),
        ),
        OptimusBone(
          isLoading: isLoading,
          child: const OptimusChip(child: Text('Skeleton Chip')),
        ),
      ],
    ),
  );
}
