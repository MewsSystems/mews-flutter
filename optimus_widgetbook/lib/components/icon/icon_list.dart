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
      listSize: context.knobs.listOrNull(
        label: 'Size',
        initialOption: null,
        options: OptimusIconListSize.values,
        labelBuilder: (value) => value?.name ?? 'Not set',
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
    colorOption: OptimusIconColorOption.primary,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.plus,
    label: 'Plus (success color)',
    description: 'Description',
    colorOption: OptimusIconColorOption.success,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.plus,
    label: 'Plus (info color)',
    description: 'Description',
    colorOption: OptimusIconColorOption.info,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.delete,
    label: 'Delete (warning color)',
    description: 'Description',
    colorOption: OptimusIconColorOption.warning,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.edit,
    label: 'Edit (danger color)',
    description: 'Description',
    colorOption: OptimusIconColorOption.danger,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.chevron_right,
    label: 'Chevron right (primary color)',
    description: 'Description',
    colorOption: OptimusIconColorOption.primary,
  ),
  const OptimusIconListItem(
    iconData: OptimusIcons.chevron_left,
    label: 'Chevron left (basic color)',
    description: 'Description',
    colorOption: OptimusIconColorOption.basic,
  ),
];
