import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story iconStory = Story(
  name: 'Media/Icons/Icon',
  builder: (context) {
    final k = context.knobs;
    final icon = k.options(
      label: 'Icon',
      initial: OptimusIcons.plus,
      options: _icons,
    );
    final size = k.options(
      label: 'Size',
      initial: OptimusIconSize.medium,
      options: _sizes,
    );

    return ListView(
      children: _colors
          .map(
            (c) => OptimusListTile(
              title: OptimusTitleSmall(child: Text(c.label.toUpperCase())),
              prefix: OptimusIcon(
                iconData: icon,
                colorOption: c.value,
                iconSize: size,
              ),
            ),
          )
          .toList(),
    );
  },
);

final List<Option<IconData>> _icons = [
  const Option(label: 'Mews Logo', value: OptimusIcons.mews_logo),
  const Option(label: 'Magic', value: OptimusIcons.magic),
  const Option(label: 'Plus', value: OptimusIcons.plus),
  const Option(label: 'Delete', value: OptimusIcons.delete),
  const Option(label: 'Edit', value: OptimusIcons.edit),
  const Option(label: 'Chevron right', value: OptimusIcons.chevron_right),
  const Option(label: 'Chevron left', value: OptimusIcons.chevron_left),
];

final _colors = [
  const Option(label: 'Basic', value: OptimusIconColorOption.basic),
  const Option(label: 'Primary', value: OptimusIconColorOption.primary),
  const Option(label: 'Success', value: OptimusIconColorOption.success),
  const Option(label: 'Info', value: OptimusIconColorOption.info),
  const Option(label: 'Warning', value: OptimusIconColorOption.warning),
  const Option(label: 'Danger', value: OptimusIconColorOption.danger),
  const Option(label: 'Inverse', value: OptimusIconColorOption.inverse),
  const Option(label: 'Inherit', value: null),
];

final _sizes = OptimusIconSize.values.toOptions();
