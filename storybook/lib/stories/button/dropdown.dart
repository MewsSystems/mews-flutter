import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dropdownButton = Story(
  name: 'Buttons/Dropdown Button',
  builder: (context) {
    final k = context.knobs;
    final isEnabled = k.boolean(label: 'Enabled', initial: true);

    return SingleChildScrollView(
      child: Column(
        children: OptimusDropdownButtonVariant.values
            .map(
              (v) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: OptimusDropDownButton<int>(
                  size: k.options(
                    label: 'Size',
                    initial: OptimusWidgetSize.large,
                    options: sizeOptions,
                  ),
                  items: Iterable<int>.generate(10)
                      .map(
                        (i) => ListDropdownTile<int>(
                          value: i,
                          title: Text('Dropdown tile #$i'),
                          subtitle: Text('Subtitle #$i'),
                        ),
                      )
                      .toList(),
                  onItemSelected: isEnabled ? (_) => () {} : null,
                  variant: v,
                  child:
                      Text(k.text(label: 'Label', initial: 'Dropdown button')),
                ),
              ),
            )
            .toList(),
      ),
    );
  },
);
