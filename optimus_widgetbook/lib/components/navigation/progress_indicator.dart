import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Progress Indicator',
  type: OptimusProgressIndicator,
  path: '[Navigation]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final layout = k.object.dropdown(
    label: 'Layout',
    initialOption: Axis.vertical,
    options: Axis.values,
    labelBuilder: enumLabelBuilder,
  );

  return OptimusProgressIndicator(
    layout: layout,
    items: _items,
    currentItem: k.int.slider(
      label: 'Current',
      initialValue: 0,
      max: _items.length - 1,
    ),
    maxItem: k.int.slider(
      label: 'Max',
      initialValue: 2,
      max: _items.length - 1,
    ),
  );
}

const List<OptimusProgressIndicatorItem> _items = [
  OptimusProgressIndicatorItem(
    text: Text('Step with long title'),
    description: Text('Some description goes here'),
  ),
  OptimusProgressIndicatorItem(text: Text('Step 2')),
  OptimusProgressIndicatorItem(
    text: Text('Step 3'),
    description: Text('Description'),
  ),
  OptimusProgressIndicatorItem(
    text: Text('Step 4'),
    description: Text('Description'),
  ),
];
