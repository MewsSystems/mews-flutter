import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story iconStory = Story(
  section: 'Icons',
  name: 'Icon',
  builder: (_, k) {
    final icon = k.options('Icon', initial: OptimusIcons.plus, options: _icons);
    final size =
        k.options('Size', initial: OptimusIconSize.medium, options: _sizes);

    return ListView(
      children: OptimusColorOption.values
          .map((c) => OptimusListTile(
                title: OptimusSubsectionTitle(
                  child: Text(describeEnum(c).toUpperCase()),
                ),
                prefix: OptimusIcon(
                  iconData: icon,
                  colorOption: c,
                  iconSize: size,
                ),
              ))
          .toList(),
    );
  },
);

final Story supplementaryIconStory = Story(
  section: 'Icons',
  name: 'Supplementary icon',
  builder: (_, k) {
    final icon = k.options('Icon', initial: OptimusIcons.edit, options: _icons);

    return ListView(
      children: OptimusColorOption.values
          .map((c) => OptimusListTile(
                title: OptimusSubsectionTitle(
                  child: Text(describeEnum(c).toUpperCase()),
                ),
                prefix: OptimusSupplementaryIcon(
                  iconData: icon,
                  colorOption: c,
                ),
              ))
          .toList(),
    );
  },
);

final List<Option<IconData>> _icons = [
  const Option('Mews Logo', OptimusIcons.mews_logo_small),
  const Option('Magic', OptimusIcons.magic),
  const Option('Plus', OptimusIcons.plus),
  const Option('Delete', OptimusIcons.delete),
  const Option('Edit', OptimusIcons.edit),
  const Option('Chevron right', OptimusIcons.chevron_right),
  const Option('Chevron left', OptimusIcons.chevron_left),
];

final List<Option<OptimusIconSize>> _sizes =
    OptimusIconSize.values.map((e) => Option(describeEnum(e), e)).toList();
