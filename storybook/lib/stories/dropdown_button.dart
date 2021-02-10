import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dropdownButton = Story(
  section: 'Button',
  name: 'Dropdown button',
  builder: (_, k) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: OptimusDropDownButton<int>(
      isEnabled: k.boolean('Enabled', initial: true),
      size: k.options(
        'Size',
        initial: OptimusWidgetSize.large,
        options: sizeOptions,
      ),
      label: k.text('Label', initial: 'Dropdown button'),
      items: Iterable<int>.generate(10)
          .map((i) =>
              ListDropdownTile<int>(value: i, title: Text('Dropdown tile #$i')))
          .toList(),
      onChanged: (_) => null,
    ),
  ),
);
