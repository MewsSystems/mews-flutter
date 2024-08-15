import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story standaloneLink = Story(
  name: 'Navigation/Link/Standalone Link',
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
                  isExternal: k.boolean(label: 'External', initial: false),
                  useStrong: k.boolean(label: 'Strong', initial: false),
                  variant: k.options(
                    label: 'Variant',
                    initial: OptimusLinkVariant.primary,
                    options: OptimusLinkVariant.values.toOptions(),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  },
);
