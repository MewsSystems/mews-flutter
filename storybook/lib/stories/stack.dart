import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story verticalStackStory = Story(
  section: 'Stack',
  name: 'Vertical stack',
  builder: (_, k) {
    return OptimusStack(
      children: _items,
      distribution: OptimusStackDistribution.spaceBetween,
    );
  },
);

final Story horizontalStackStory = Story(
  section: 'Stack',
  name: 'Horizontal stack',
  builder: (_, k) {
    return const Text('horizontalStackStory');
  },
);

final _items = Iterable<int>.generate(3)
    .map((e) => Container(
          height: 40,
          width: 40,
          color: Colors.green,
        ))
    .toList();

final List<Option<OptimusStackDistribution>> _distribution =
    OptimusStackDistribution.values
        .map((e) => Option(describeEnum(e), e))
        .toList();

final List<Option<OptimusStackBreakpoint>> _breakpoint = OptimusStackBreakpoint
    .values
    .map((e) => Option(describeEnum(e), e))
    .toList();

final List<Option<OptimusStackSpacing>> _spacing =
    OptimusStackSpacing.values.map((e) => Option(describeEnum(e), e)).toList();
