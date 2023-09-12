import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tabStory = Story(
  name: 'Data Display/Tab',
  builder: (BuildContext context) {
    final knobs = context.knobs;

    final label = knobs.text(label: 'Label', initial: 'Label');
    final leadingIcon = knobs.options(
      label: 'Icon',
      options: exampleIcons,
      initial: null,
    );
    final badge = knobs.text(label: 'Badge', initial: '');
    final enableEmptyBadge =
        knobs.boolean(label: 'Enable empty badge', initial: true);

    final badgeText = (badge.isEmpty && !enableEmptyBadge) ? null : badge;

    return OptimusTab(icon: leadingIcon, label: label, badge: badgeText);
  },
);
