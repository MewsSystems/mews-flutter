import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Stack', type: OptimusStack, path: '[Layout]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusStack(
    direction: k.object.dropdown(
      label: 'Direction',
      initialOption: Axis.vertical,
      options: Axis.values,
      labelBuilder: enumLabelBuilder,
    ),
    mainAxisAlignment: k.object.dropdown(
      label: 'Main axis',
      initialOption: OptimusStackAlignment.center,
      options: OptimusStackAlignment.values,
      labelBuilder: enumLabelBuilder,
    ),
    crossAxisAlignment: k.object.dropdown(
      label: 'Cross axis',
      initialOption: OptimusStackAlignment.center,
      options: OptimusStackAlignment.values,
      labelBuilder: enumLabelBuilder,
    ),
    distribution: k.object.dropdown(
      label: 'Distribution',
      initialOption: OptimusStackDistribution.basic,
      options: OptimusStackDistribution.values,
      labelBuilder: enumLabelBuilder,
    ),
    breakpoint: k.objectOrNull.dropdown(
      label: 'Breakpoint',
      initialOption: null,
      options: Breakpoint.values,
      labelBuilder: enumOrNullLabelBuilder,
    ),
    spacing: k.object.dropdown(
      label: 'Spacing',
      initialOption: OptimusStackSpacing.spacing100,
      options: OptimusStackSpacing.values,
      labelBuilder: enumLabelBuilder,
    ),
    children: _items,
  );
}

final _items = [
  Container(height: 40, width: 40, color: Colors.red),
  Container(height: 10, width: 10, color: Colors.green),
  Container(height: 20, width: 20, color: Colors.blue),
];
