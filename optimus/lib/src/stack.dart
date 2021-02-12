import 'package:dfunc/dfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/spacing.dart';

enum OptimusStackDistribution {
  basic,
  spaceBetween,
  stretch,
}
//todo: implement nullable
enum OptimusStackBreakpoint { extraSmall, small, medium, large, extraLarge }

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
    this.spacing = OptimusStackSpacing.spacing0,
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
            : Padding(
                padding: direction == Axis.vertical
                    ? _verticalPadding
                    : _horizontalPadding,
                child: e),
      )
      .toList();

  // ignore: missing_return
  EdgeInsets get _verticalPadding {
    switch (spacing) {
      case OptimusStackSpacing.spacing0:
        return const EdgeInsets.only(bottom: 0);
      case OptimusStackSpacing.spacing25:
        return const EdgeInsets.only(bottom: spacing25);
      case OptimusStackSpacing.spacing50:
        return const EdgeInsets.only(bottom: spacing50);
      case OptimusStackSpacing.spacing100:
        return const EdgeInsets.only(bottom: spacing100);
      case OptimusStackSpacing.spacing200:
        return const EdgeInsets.only(bottom: spacing200);
      case OptimusStackSpacing.spacing300:
        return const EdgeInsets.only(bottom: spacing300);
      case OptimusStackSpacing.spacing400:
        return const EdgeInsets.only(bottom: spacing400);
      case OptimusStackSpacing.spacing500:
        return const EdgeInsets.only(bottom: spacing500);
    }
  }

  // ignore: missing_return
  EdgeInsets get _horizontalPadding {
    switch (spacing) {
      case OptimusStackSpacing.spacing0:
        return const EdgeInsets.only(right: 0);
      case OptimusStackSpacing.spacing25:
        return const EdgeInsets.only(right: spacing25);
      case OptimusStackSpacing.spacing50:
        return const EdgeInsets.only(right: spacing50);
      case OptimusStackSpacing.spacing100:
        return const EdgeInsets.only(right: spacing100);
      case OptimusStackSpacing.spacing200:
        return const EdgeInsets.only(right: spacing200);
      case OptimusStackSpacing.spacing300:
        return const EdgeInsets.only(right: spacing300);
      case OptimusStackSpacing.spacing400:
        return const EdgeInsets.only(right: spacing400);
      case OptimusStackSpacing.spacing500:
        return const EdgeInsets.only(right: spacing500);
    }
  }
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
