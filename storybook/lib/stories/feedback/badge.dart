import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story badgeStory = Story(
  name: 'Feedback/Badge',
  builder: (context) {
    final knobs = context.knobs;
    final useGrayBackground =
        knobs.boolean(label: 'Grey background', initial: true);
    final isOutlined = knobs.boolean(label: 'Outline', initial: true);
    final variant = knobs.options(
      label: 'Variant',
      initial: OptimusBadgeVariant.values.first,
      options: OptimusBadgeVariant.values.toOptions(),
    );

    return Container(
      width: 600,
      height: 400,
      color: useGrayBackground ? Colors.grey : null,
      child: Center(
        child: OptimusBadge(
          text: knobs.text(label: 'Content', initial: 'Info Text'),
          variant: variant,
          isOutlined: isOutlined,
        ),
      ),
    );
  },
);
