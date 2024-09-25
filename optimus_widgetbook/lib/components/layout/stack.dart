import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Stack',
  type: OptimusStack,
  path: '[Layout]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusStack(
    direction: k.list(
      label: 'Direction',
      initialOption: Axis.vertical,
      options: Axis.values,
    ),
    mainAxisAlignment: k.list(
      label: 'Main axis',
      initialOption: OptimusStackAlignment.center,
      options: OptimusStackAlignment.values,
    ),
    crossAxisAlignment: k.list(
      label: 'Cross axis',
      initialOption: OptimusStackAlignment.center,
      options: OptimusStackAlignment.values,
    ),
    distribution: k.list(
      label: 'Distribution',
      initialOption: OptimusStackDistribution.basic,
      options: OptimusStackDistribution.values,
    ),
    breakpoint: k.listOrNull(
      label: 'Breakpoint',
      initialOption: null,
      options: Breakpoint.values,
    ),
    spacing: k.list(
      label: 'Spacing',
      initialOption: OptimusStackSpacing.spacing100,
      options: OptimusStackSpacing.values,
    ),
    children: _items,
  );
}

final _items = [
  Container(
    height: 40,
    width: 40,
    color: Colors.red,
  ),
  Container(
    height: 10,
    width: 10,
    color: Colors.green,
  ),
  Container(
    height: 20,
    width: 20,
    color: Colors.blue,
  ),
];
