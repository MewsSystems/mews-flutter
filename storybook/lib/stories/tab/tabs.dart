import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tabsStory = Story(
  name: 'Data Display/Tabs',
  builder: (BuildContext context) {
    final knobs = context.knobs;
    final icon = knobs.options(
      label: 'Icon',
      options: exampleIcons,
      initial: null,
    );
    final badge = knobs.text(label: 'Badge');

    return Container(
      color: OptimusTheme.of(context).colors.success500t16,
      constraints: const BoxConstraints(maxWidth: _tabBarWidth, maxHeight: 200),
      child: OptimusTabBar(
        tabs: _items
            .map(
              (i) => OptimusTab(
                label: i.isEven ? 'Tab with long name' : 'Tab ${i + 1}',
                icon: i.isOdd ? icon : null,
                badge: i.isOdd ? badge : null,
                maxWidth: _tabBarWidth / _items.length,
              ),
            )
            .toList(),
        pages: _items.map((i) => Center(child: Text('Page ${i + 1}'))).toList(),
      ),
    );
  },
);

final Iterable<int> _items = Iterable<int>.generate(3);
const double _tabBarWidth = 400.0;
