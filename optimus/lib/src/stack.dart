import 'package:dfunc/dfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/breakpoint.dart';
import 'package:optimus/src/spacing.dart';

enum OptimusStackAlignment {
  /// Default value.	All items in a stack are aligned to the start of the
  /// container.
  start,

  /// All items in a stack are aligned to the center of the container.
  center,

  /// All items in a stack are aligned to the center of the container.
  end,
}

enum OptimusStackDistribution {
  /// Default value. The space between individual items is inflexible and
  /// defined by spacing tokens.
  basic,

  /// Items are evenly distributed within the stack.
  spaceBetween,

  /// Items are stretched equally to fill any available space in addition to
  /// predefined spacing between them.
  stretch,
}

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

/// Use Stacks when you need to lay out components by choosing either a
/// horizontal or vertical axis.
///
/// Stacks are flexible in order to cover a wide range of scenarios.
class OptimusStack extends StatelessWidget {
  const OptimusStack({
    super.key,
    required this.children,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = OptimusStackAlignment.start,
    this.crossAxisAlignment = OptimusStackAlignment.center,
    this.distribution = OptimusStackDistribution.basic,
    this.breakpoint,
    this.spacing = OptimusStackSpacing.spacing0,
    this.mainAxisSize = MainAxisSize.max,
  });

  /// Establishes a horizontal or vertical direction for stack items.
  final Axis direction;

  /// Sets the alignment of stack items within the main direction.
  final OptimusStackAlignment mainAxisAlignment;

  /// Sets the alignment of stack items within the cross direction.
  final OptimusStackAlignment crossAxisAlignment;

  /// Sets the distribution of items along main axis inside a stack.
  final OptimusStackDistribution distribution;

  /// The widgets below this widget in the tree.
  final List<Widget> children;

  /// Changes the value to trigger vertical item stacking on a user's
  /// selected breakpoint range.
  final Breakpoint? breakpoint;

  /// Changes spacing between stack items.
  final OptimusStackSpacing spacing;

  /// Defines amount of space taken by the main axis.
  final MainAxisSize mainAxisSize;

  Axis _direction(BuildContext context) {
    final breakpoint = this.breakpoint;

    if (breakpoint == null || direction == Axis.vertical) {
      return direction;
    }

    final screenSize = MediaQuery.of(context).screenBreakpoint;

    return screenSize.index <= breakpoint.index
        ? Axis.vertical
        : Axis.horizontal;
  }

  List<Widget> _children(BuildContext context) {
    switch (distribution) {
      case OptimusStackDistribution.basic:
        return _childrenWithSpacing(context, children);
      case OptimusStackDistribution.spaceBetween:
        return children.intersperse(const Spacer()).toList();
      case OptimusStackDistribution.stretch:
        final wrappedChildren =
            children.map((c) => Expanded(child: c)).toList();
        return _childrenWithSpacing(context, wrappedChildren);
    }
  }

  List<Widget> _childrenWithSpacing(
    BuildContext context,
    List<Widget> children,
  ) {
    final direction = _direction(context);
    final spacer = SizedBox(
      width: direction == Axis.vertical ? null : spacing.size,
      height: direction == Axis.vertical ? spacing.size : null,
    );

    return children.intersperse(spacer).toList();
  }

  @override
  Widget build(BuildContext context) => Flex(
        direction: _direction(context),
        mainAxisAlignment: mainAxisAlignment.mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment.crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: _children(context),
      );
}

extension on OptimusStackSpacing {
  double get size {
    switch (this) {
      case OptimusStackSpacing.spacing0:
        return spacing0;
      case OptimusStackSpacing.spacing25:
        return spacing25;
      case OptimusStackSpacing.spacing50:
        return spacing50;
      case OptimusStackSpacing.spacing100:
        return spacing100;
      case OptimusStackSpacing.spacing200:
        return spacing200;
      case OptimusStackSpacing.spacing300:
        return spacing300;
      case OptimusStackSpacing.spacing400:
        return spacing400;
      case OptimusStackSpacing.spacing500:
        return spacing500;
    }
  }
}

extension on OptimusStackAlignment {
  CrossAxisAlignment get crossAxisAlignment {
    switch (this) {
      case OptimusStackAlignment.start:
        return CrossAxisAlignment.start;
      case OptimusStackAlignment.center:
        return CrossAxisAlignment.center;
      case OptimusStackAlignment.end:
        return CrossAxisAlignment.end;
    }
  }

  MainAxisAlignment get mainAxisAlignment {
    switch (this) {
      case OptimusStackAlignment.start:
        return MainAxisAlignment.start;
      case OptimusStackAlignment.center:
        return MainAxisAlignment.center;
      case OptimusStackAlignment.end:
        return MainAxisAlignment.end;
    }
  }
}
