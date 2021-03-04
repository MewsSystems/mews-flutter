import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story cardStory = Story(
  section: 'Cards',
  name: 'Card',
  builder: (_, k) => OptimusCard(
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
  ),
);

final Story nestedCardStory = Story(
  section: 'Cards',
  name: 'Nested card',
  builder: (_, k) => OptimusNestedCard(
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
  ),
);

Widget get _content => Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      color: OptimusLightColors.success500t16,
      child: const Text('Content'),
    );

final List<Option<OptimusCardSpacing>> _paddings =
    OptimusCardSpacing.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<OptimusBasicCardVariant>> _basicCardVariants =
    OptimusBasicCardVariant.values
        .map((e) => Option(describeEnum(e), e))
        .toList();

final List<Option<OptimusNestedCardVariant>> _nestedCardVariants =
    OptimusNestedCardVariant.values
        .map((e) => Option(describeEnum(e), e))
        .toList();

final List<Option<OptimusCardAttachment>> _attachments = OptimusCardAttachment
    .values
    .map((e) => Option(describeEnum(e), e))
    .toList();
