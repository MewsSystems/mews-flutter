import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story verticalStackStory = Story(
  name: 'Stack',
  builder: (_, k) => OptimusStack(
    direction: k.options(
      'Direction',
      initial: Axis.vertical,
      options: _direction,
    ),
    mainAxisAlignment: k.options(
      'Main axis',
      initial: OptimusStackAlignment.start,
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
      options: _distribution,
    ),
    breakpoint: k.options(
      'Breakpoint',
      initial: null,
      options: _breakpoint,
    ),
    spacing: k.options(
      'Spacing',
      initial: OptimusStackSpacing.spacing100,
      options: _spacing,
    ),
    children: _items,
  ),
);

final _items = Iterable<int>.generate(3)
    .map((e) => Container(
          height: 40,
          width: 40,
          color: Colors.green,
        ))
    .toList();

final List<Option<Axis>> _direction =
    Axis.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<OptimusStackAlignment>> _alignment = OptimusStackAlignment
    .values
    .map((e) => Option(describeEnum(e), e))
    .toList();

final List<Option<OptimusStackDistribution>> _distribution =
    OptimusStackDistribution.values
        .map((e) => Option(describeEnum(e), e))
        .toList();

final List<Option<Breakpoint>> _breakpoint =
    Breakpoint.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<OptimusStackSpacing>> _spacing =
    OptimusStackSpacing.values.map((e) => Option(describeEnum(e), e)).toList();
