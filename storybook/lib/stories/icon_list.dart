import 'package:flutter/foundation.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story iconListStory = Story(
  section: 'Icons',
  name: 'Icon list',
  builder: (_, k) => OptimusIconList(
    items: _items,
    listSize: k.options(label: 'Size', initial: null, options: _sizes),
  ),
);

final List<OptimusIconListItem> _items = [
  const OptimusIconListItem(
    iconData: OptimusIcons.folder_opened,
    label: 'Folder (default color)',
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.magic,
    label: 'Magic (primary color)',
    colorOption: OptimusColorOption.primary,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.plus,
    label: 'Plus (success color)',
    description: 'Description',
    colorOption: OptimusColorOption.success,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.delete,
    label: 'Delete (warning color)',
    description: 'Description',
    colorOption: OptimusColorOption.warning,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.edit,
    label: 'Edit (danger color)',
    description: 'Description',
    colorOption: OptimusColorOption.danger,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.chevron_right,
    label: 'Chevron right (primary color)',
    description: 'Description',
    colorOption: OptimusColorOption.primary,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.chevron_left,
    label: 'Chevron left (basic color)',
    description: 'Description',
    colorOption: OptimusColorOption.basic,
  ),
];

final List<Option<OptimusIconListSize>> _sizes = [
  const Option('', null),
  ...OptimusIconListSize.values.map((e) => Option(describeEnum(e), e)).toList()
];
