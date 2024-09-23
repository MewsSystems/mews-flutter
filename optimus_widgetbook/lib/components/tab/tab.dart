import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Tab',
  type: OptimusTab,
  path: '[Data Display]',
)
Widget createDefaultStyle(BuildContext context) {
  final knobs = context.knobs;

  final label = knobs.string(label: 'Label', initialValue: 'Label');
  final leadingIcon = knobs.list(
    label: 'Icon',
    options: exampleIconsWithNull,
    initialOption: null,
  );
  final badge = knobs.string(label: 'Badge', initialValue: '');
  final enableEmptyBadge =
      knobs.boolean(label: 'Enable empty badge', initialValue: true);

  final badgeText = (badge.isEmpty && !enableEmptyBadge) ? null : badge;

  return OptimusTab(icon: leadingIcon, label: label, badge: badgeText);
}
