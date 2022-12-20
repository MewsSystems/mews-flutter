import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story standaloneLink = Story(
  name: 'Link/Standalone link',
  builder: (context) {
    final k = context.knobs;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: OptimusStandaloneLinkSize.values
            .map(
              (size) => Padding(
                padding: const EdgeInsets.all(8),
                child: OptimusStandaloneLink(
                  onPressed:
                      k.boolean(label: 'Enabled', initial: true) ? () {} : null,
                  text: Text(k.text(label: 'Text', initial: 'Link')),
                  size: size,
                  external: k.boolean(label: 'External', initial: false),
                  color: k.options(
                    label: 'Color',
                    initial: null,
                    options: _colors,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  },
);

const _colors = [
  Option(label: 'none', value: null),
  Option(label: 'black', value: OptimusSemanticColors.grey1100),
  Option(label: 'green', value: OptimusSemanticColors.grey500),
  Option(label: 'red', value: OptimusSemanticColors.red500),
];
