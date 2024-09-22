import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon',
  type: OptimusIcon,
  path: '[Media]/Icons',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final icon = k.list(
    label: 'Icon',
    initialOption: OptimusIcons.plus,
    options: exampleIcons,
  );
  final size = k.list(
    label: 'Size',
    initialOption: OptimusIconSize.medium,
    options: OptimusIconSize.values,
  );

  return ListView(
    children: _colors
        .map(
          (c) => OptimusListTile(
            title: OptimusTitleSmall(
              child: Text(c != null ? c.name.toUpperCase() : 'EMPTY'),
            ),
            prefix: OptimusIcon(
              iconData: icon,
              colorOption: c,
              iconSize: size,
            ),
          ),
        )
        .toList(),
  );
}

final _colors = [...OptimusIconColorOption.values, null];
