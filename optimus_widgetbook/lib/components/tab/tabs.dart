import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Tab Bar',
  type: OptimusTabBar,
  path: '[Data Display]',
)
Widget createDefaultStyle(BuildContext context) {
  final knobs = context.knobs;
  final icon = knobs.listOrNull(
    label: 'Icon',
    options: exampleIconsWithNull,
    initialOption: null,
  );
  final badge = knobs.string(label: 'Badge');

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
}

final Iterable<int> _items = Iterable<int>.generate(3);
const double _tabBarWidth = 400.0;
