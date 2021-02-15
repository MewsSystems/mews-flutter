import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story stackStory = Story(
  name: 'Stack',
  builder: (_, k) => OptimusStack(
    direction: k.options(
      'Direction',
      initial: Axis.vertical,
      options: Axis.values.toOptions(),
    ),
    mainAxisAlignment: k.options(
      'Main axis',
      initial: OptimusStackAlignment.center,
      options: _alignment,
    ),
    crossAxisAlignment: k.options(
      'Cross axis',
      initial: OptimusStackAlignment.center,
      options: _alignment,
    ),
    distribution: k.options(
      'Distribution',
      initial: OptimusStackDistribution.basic,
      options: OptimusStackDistribution.values.toOptions(),
    ),
    breakpoint: k.options(
      'Breakpoint',
      initial: null,
      options: Breakpoint.values.toOptions(hasEmpty: true),
    ),
    spacing: k.options(
      'Spacing',
      initial: OptimusStackSpacing.spacing100,
      options: OptimusStackSpacing.values.toOptions(),
    ),
    children: _items,
  ),
);

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

final List<Option<OptimusStackAlignment>> _alignment =
    OptimusStackAlignment.values.toOptions();
