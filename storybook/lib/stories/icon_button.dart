import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story iconButton = Story(
  section: 'Button',
  name: 'IconButton',
  builder: (_, k) => SingleChildScrollView(
    child: Column(
      children: OptimusIconButtonType.values
          .map(
            (t) => Padding(
              padding: const EdgeInsets.all(8),
              child: OptimusIconButton(
                onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
                icon: Icon(k.options('Icon', initial: OptimusIcons.plus, options: exampleIcons)),
                size: k.options('Size', initial: OptimusWidgetSize.large, options: sizeOptions),
                type: t,
              ),
            ),
          )
          .toList(),
    ),
  ),
);
