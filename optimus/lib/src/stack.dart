import 'package:dfunc/dfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum OptimusStackDistribution {
  basic,
  spaceBetween,
  stretch,
}
//todo: implement nullable
enum OptimusStackBreakpoint { extraSmall, small, medium, large, extraLarge }
//todo: implement
enum OptimusStackSpacing {
  spacing0,
  spacing25,
  spacing50,
  spacing100,
  spacing200,
  spacing300,
  spacing400,
  spacing500,
}

class OptimusStack extends StatelessWidget {
  const OptimusStack({
    Key key,
    this.children,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.distribution = OptimusStackDistribution.basic,
    this.breakpoint,
    this.spacing, //todo: implement
  }) : super(key: key);

  final List<Widget> children;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final OptimusStackDistribution distribution;
  final OptimusStackBreakpoint breakpoint;
  final OptimusStackSpacing spacing;

  @override
  Widget build(BuildContext context) => Flex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: _children,
      );

  // ignore: missing_return
  List<Widget> get _children {
    switch (distribution) {
      case OptimusStackDistribution.basic:
        return _childrenWithSpacing;
      case OptimusStackDistribution.spaceBetween:
        return _intersperse(const Spacer(), children).toList();
      case OptimusStackDistribution.stretch:
        return _childrenWithSpacing.map((c) => Expanded(child: c)).toList();
    }
  }

  List<Widget> get _childrenWithSpacing => children
      .mapIndexed<Widget>(
        (i, e) => i == children.length - 1
            ? e
            //todo: add padding according to spacing and orientation
            : Padding(padding: EdgeInsets.zero, child: e),
      )
      .toList();
}

/// Puts [item] between every item in [list].
Iterable<T> _intersperse<T>(T item, Iterable<T> iterable) sync* {
  final iterator = iterable.iterator;
  if (iterator.moveNext()) {
    yield iterator.current;
    while (iterator.moveNext()) {
      yield item;
      yield iterator.current;
    }
  }
}
