import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story link = Story(
  section: 'Link',
  name: 'Standalone link',
  builder: (_, k) => SingleChildScrollView(
    child: Column(
      children: OptimusLinkSize.values
          .map((size) => Padding(
                padding: const EdgeInsets.all(8),
                child: OptimusStandaloneLink(
                  onPressed:
                      k.boolean(label: 'Enabled', initial: true) ? () {} : null,
                  text: k.text(label: 'Text', initial: 'Link'),
                  size: size,
                  color: k.options(
                    label: 'Color',
                    initial: null,
                    options: _colors,
                  ),
                ),
              ))
          .toList(),
    ),
  ),
);

const _colors = [
  Option('black', OptimusLightColors.neutral1000),
  Option('green', OptimusLightColors.success),
  Option('red', OptimusLightColors.danger),
];
