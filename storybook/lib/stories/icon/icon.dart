import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story iconStory = Story(
  name: 'Media And Icons/Icons/Icon',
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
      children: OptimusIconColorOption.values
          .map(
            (c) => OptimusListTile(
              title: OptimusSubsectionTitle(
                child: Text(describeEnum(c).toUpperCase()),
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
  },
);

final Story supplementaryIconStory = Story(
  name: 'Media And Icons/Icons/Supplementary icon',
  builder: (context) {
    final k = context.knobs;
    final icon = k.options(
      label: 'Icon',
      initial: OptimusIcons.edit,
      options: _icons,
    );

    return ListView(
      children: OptimusIconColorOption.values
          .map(
            (c) => OptimusListTile(
              title: OptimusSubsectionTitle(
                child: Text(describeEnum(c).toUpperCase()),
              ),
              prefix: OptimusSupplementaryIcon(
                iconData: icon,
                colorOption: c,
              ),
            ),
          )
          .toList(),
    );
  },
);

final List<Option<IconData>> _icons = [
  const Option(label: 'Mews Logo', value: OptimusIcons.mews_logo_small),
  const Option(label: 'Magic', value: OptimusIcons.magic),
  const Option(label: 'Plus', value: OptimusIcons.plus),
  const Option(label: 'Delete', value: OptimusIcons.delete),
  const Option(label: 'Edit', value: OptimusIcons.edit),
  const Option(label: 'Chevron right', value: OptimusIcons.chevron_right),
  const Option(label: 'Chevron left', value: OptimusIcons.chevron_left),
];

final _sizes = OptimusIconSize.values.toOptions();
