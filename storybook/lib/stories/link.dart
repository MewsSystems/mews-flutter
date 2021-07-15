import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story link = Story(
  section: 'Link',
  name: 'Link',
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
                ),
              ))
          .toList(),
    ),
  ),
);
