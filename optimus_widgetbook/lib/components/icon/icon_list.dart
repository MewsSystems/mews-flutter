import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon List',
  type: OptimusIconList,
  path: '[Media]/Icons',
)
Widget createDefaultStyle(BuildContext context) => OptimusIconList(
  items: _items,
  listSize: context.knobs.objectOrNull.dropdown(
    label: 'Size',
    initialOption: null,
    options: OptimusIconListSize.values,
    labelBuilder: (value) => value.name,
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
    colorOption: .primary,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.plus,
    label: 'Plus (success color)',
    description: 'Description',
    colorOption: .success,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.plus,
    label: 'Plus (info color)',
    description: 'Description',
    colorOption: .info,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.delete,
    label: 'Delete (warning color)',
    description: 'Description',
    colorOption: .warning,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.edit,
    label: 'Edit (danger color)',
    description: 'Description',
    colorOption: .danger,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.chevron_right,
    label: 'Chevron right (primary color)',
    description: 'Description',
    colorOption: .primary,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.chevron_left,
    label: 'Chevron left (basic color)',
    description: 'Description',
    colorOption: .basic,
  ),
];
