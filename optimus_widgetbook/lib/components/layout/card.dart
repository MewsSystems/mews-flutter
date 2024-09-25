import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Card',
  type: OptimusCard,
  path: '[Layout]/Cards',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusCard(
    padding: k.list(
      label: 'Padding',
      initialOption: OptimusCardSpacing.spacing200,
      options: _paddings,
    ),
    variant: k.list(
      label: 'Variant',
      initialOption: OptimusBasicCardVariant.normal,
      options: _basicCardVariants,
    ),
    attachment: k.list(
      label: 'Attachment',
      initialOption: OptimusCardAttachment.none,
      options: _attachments,
    ),
    radius: k.list(
      label: 'Radius',
      initialOption: OptimusCardCornerRadius.medium,
      options: OptimusCardCornerRadius.values,
    ),
    isOutlined: k.boolean(label: 'Outline', initialValue: true),
    child: const _Content(),
  );
}

@widgetbook.UseCase(
  name: 'Nested Card',
  type: OptimusNestedCard,
  path: '[Layout]/Cards',
)
Widget createNestedCard(BuildContext context) {
  final k = context.knobs;

  return OptimusNestedCard(
    padding: k.list(
      label: 'Padding',
      initialOption: OptimusCardSpacing.spacing200,
      options: _paddings,
    ),
    variant: k.list(
      label: 'Variant',
      initialOption: OptimusNestedCardVariant.normal,
      options: _nestedCardVariants,
    ),
    attachment: k.list(
      label: 'Attachment',
      initialOption: OptimusCardAttachment.none,
      options: _attachments,
    ),
    radius: k.list(
      label: 'Radius',
      initialOption: OptimusCardCornerRadius.medium,
      options: OptimusCardCornerRadius.values,
    ),
    isOutlined: k.boolean(label: 'Outline', initialValue: false),
    child: const _Content(),
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        color: OptimusTheme.of(context).colors.success500t16,
        child: const Text('Content'),
      );
}

const _paddings = OptimusCardSpacing.values;
const _basicCardVariants = OptimusBasicCardVariant.values;
const _nestedCardVariants = OptimusNestedCardVariant.values;
const _attachments = OptimusCardAttachment.values;
