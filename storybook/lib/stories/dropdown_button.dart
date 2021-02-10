import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dropdownButton = Story(
  section: 'Button',
  name: 'Dropdown button',
  builder: (_, k) => SingleChildScrollView(
    child: Column(
      children: OptimusDropdownButtonType.values
          .map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: OptimusDropDownButton<int>(
                size: k.options(
                  'Size',
                  initial: OptimusWidgetSize.large,
                  options: sizeOptions,
                ),
                label: Text(k.text('Label', initial: 'Dropdown button')),
                items: Iterable<int>.generate(10)
                    .map(
                      (i) => ListDropdownTile<int>(
                        value: i,
                        title: Text('Dropdown tile #$i'),
                      ),
                    )
                    .toList(),
                onChanged: (_) =>
                    k.boolean('Enabled', initial: true) ? () {} : null,
                type: t,
              ),
            ),
          )
          .toList(),
    ),
  ),
);
