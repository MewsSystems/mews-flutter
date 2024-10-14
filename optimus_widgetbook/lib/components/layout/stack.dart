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
      labelBuilder: (value) => value.name,
    ),
    mainAxisAlignment: k.list(
      label: 'Main axis',
      initialOption: OptimusStackAlignment.center,
      options: OptimusStackAlignment.values,
      labelBuilder: (value) => value.name,
    ),
    crossAxisAlignment: k.list(
      label: 'Cross axis',
      initialOption: OptimusStackAlignment.center,
      options: OptimusStackAlignment.values,
      labelBuilder: (value) => value.name,
    ),
    distribution: k.list(
      label: 'Distribution',
      initialOption: OptimusStackDistribution.basic,
      options: OptimusStackDistribution.values,
      labelBuilder: (value) => value.name,
    ),
    breakpoint: k.listOrNull(
      label: 'Breakpoint',
      initialOption: null,
      options: Breakpoint.values,
      labelBuilder: (value) => value?.name ?? 'Not set',
    ),
    spacing: k.list(
      label: 'Spacing',
      initialOption: OptimusStackSpacing.spacing100,
      options: OptimusStackSpacing.values,
      labelBuilder: (value) => value.name,
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
