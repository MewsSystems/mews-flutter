import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story cardStory = Story(
  name: 'Cards/Card',
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
      child: _content,
    );
  },
);

final Story nestedCardStory = Story(
  name: 'Cards/Nested card',
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
      child: _content,
    );
  },
);

Widget get _content => Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      color: OptimusLightColors.success500t16,
      child: const Text('Content'),
    );

final _paddings = OptimusCardSpacing.values.toOptions();
final _basicCardVariants = OptimusBasicCardVariant.values.toOptions();
final _nestedCardVariants = OptimusNestedCardVariant.values.toOptions();
final _attachments = OptimusCardAttachment.values.toOptions();
