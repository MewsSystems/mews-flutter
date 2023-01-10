import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story cardStory = Story(
  name: 'Structure/Cards/Card',
  builder: (context) {
    final k = context.knobs;

    return OptimusCard(
      padding: k.options(
        label: 'Padding',
        initial: OptimusCardSpacing.spacing200,
        options: _paddings,
      ),
      variant: k.options(
        label: 'Variant',
        initial: OptimusBasicCardVariant.normal,
        options: _basicCardVariants,
      ),
      attachment: k.options(
        label: 'Attachment',
        initial: OptimusCardAttachment.none,
        options: _attachments,
      ),
      child: const _Content(),
    );
  },
);

final Story nestedCardStory = Story(
  name: 'Structure/Cards/Nested card',
  builder: (context) {
    final k = context.knobs;

    return OptimusNestedCard(
      padding: k.options(
        label: 'Padding',
        initial: OptimusCardSpacing.spacing200,
        options: _paddings,
      ),
      variant: k.options(
        label: 'Variant',
        initial: OptimusNestedCardVariant.normal,
        options: _nestedCardVariants,
      ),
      attachment: k.options(
        label: 'Attachment',
        initial: OptimusCardAttachment.none,
        options: _attachments,
      ),
      child: const _Content(),
    );
  },
);

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        color: OptimusTheme.of(context).colors.success500t16,
        child: const Text('Content'),
      );
}

final _paddings = OptimusCardSpacing.values.toOptions();
final _basicCardVariants = OptimusBasicCardVariant.values.toOptions();
final _nestedCardVariants = OptimusNestedCardVariant.values.toOptions();
final _attachments = OptimusCardAttachment.values.toOptions();
