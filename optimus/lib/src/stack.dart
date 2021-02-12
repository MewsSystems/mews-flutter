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
  /// Default value. The space betweeen individual items is inflexible and
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
    Key key,
    this.children,
    this.direction = Axis.vertical,
    this.mainAxisAlignment = OptimusStackAlignment.start,
    this.crossAxisAlignment = OptimusStackAlignment.center,
    this.distribution = OptimusStackDistribution.basic,
    this.breakpoint,
    this.spacing = OptimusStackSpacing.spacing0,
  }) : super(key: key);

  final List<Widget> children;
  final Axis direction;
  final OptimusStackAlignment mainAxisAlignment;
  final OptimusStackAlignment crossAxisAlignment;
  final OptimusStackDistribution distribution;
  final Breakpoint breakpoint;
  final OptimusStackSpacing spacing;

  @override
  Widget build(BuildContext context) => Flex(
        direction: _direction(context),
        mainAxisAlignment: _mainAxisAlignment,
        crossAxisAlignment: _crossAxisAlignment,
        children: _children(context),
      );

  // ignore: missing_return
  Axis _direction(BuildContext context) {
    if (breakpoint == null) {
      return direction;
    }

    final screenSize = MediaQuery.of(context).screenBreakpoint;
    switch (breakpoint) {
      case Breakpoint.extraSmall:
        return _extraSmallDirection(screenSize);
      case Breakpoint.small:
        return _smallDirection(screenSize);
      case Breakpoint.medium:
        return _mediumDirection(screenSize);
      case Breakpoint.large:
        return _largeDirection(screenSize);
      case Breakpoint.extraLarge:
        return Axis.vertical;
    }
  }

  // ignore: missing_return
  Axis _extraSmallDirection(Breakpoint screenSize) {
    switch (screenSize) {
      case Breakpoint.extraSmall:
        return Axis.vertical;
      case Breakpoint.small:
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return Axis.horizontal;
    }
  }

  // ignore: missing_return
  Axis _smallDirection(Breakpoint screenSize) {
    switch (screenSize) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
        return Axis.vertical;
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return Axis.horizontal;
    }
  }

  // ignore: missing_return
  Axis _mediumDirection(Breakpoint screenSize) {
    switch (screenSize) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
      case Breakpoint.medium:
        return Axis.vertical;
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return Axis.horizontal;
    }
  }

  // ignore: missing_return
  Axis _largeDirection(Breakpoint screenSize) {
    switch (screenSize) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
      case Breakpoint.medium:
      case Breakpoint.large:
        return Axis.vertical;
      case Breakpoint.extraLarge:
        return Axis.horizontal;
    }
  }

  // ignore: missing_return
  MainAxisAlignment get _mainAxisAlignment {
    switch (mainAxisAlignment) {
      case OptimusStackAlignment.start:
        return MainAxisAlignment.start;
      case OptimusStackAlignment.center:
        return MainAxisAlignment.center;
      case OptimusStackAlignment.end:
        return MainAxisAlignment.end;
    }
  }

  // ignore: missing_return
  CrossAxisAlignment get _crossAxisAlignment {
    switch (crossAxisAlignment) {
      case OptimusStackAlignment.start:
        return CrossAxisAlignment.start;
      case OptimusStackAlignment.center:
        return CrossAxisAlignment.center;
      case OptimusStackAlignment.end:
        return CrossAxisAlignment.end;
    }
  }

  // ignore: missing_return
  List<Widget> _children(BuildContext context) {
    switch (distribution) {
      case OptimusStackDistribution.basic:
        return _childrenWithSpacing(context, children);
      case OptimusStackDistribution.spaceBetween:
        return _intersperse(const Spacer(), children).toList();
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
    final spacer = _direction(context) == Axis.vertical
        ? _verticalSpacer
        : _horizontalSpacer;

    return _intersperse(spacer, children).toList();
  }

  // ignore: missing_return
  Widget get _verticalSpacer {
    switch (spacing) {
      case OptimusStackSpacing.spacing0:
        return const _VerticalSpacer(spacing: spacing0);
      case OptimusStackSpacing.spacing25:
        return const _VerticalSpacer(spacing: spacing25);
      case OptimusStackSpacing.spacing50:
        return const _VerticalSpacer(spacing: spacing50);
      case OptimusStackSpacing.spacing100:
        return const _VerticalSpacer(spacing: spacing100);
      case OptimusStackSpacing.spacing200:
        return const _VerticalSpacer(spacing: spacing200);
      case OptimusStackSpacing.spacing300:
        return const _VerticalSpacer(spacing: spacing300);
      case OptimusStackSpacing.spacing400:
        return const _VerticalSpacer(spacing: spacing400);
      case OptimusStackSpacing.spacing500:
        return const _VerticalSpacer(spacing: spacing500);
    }
  }

  // ignore: missing_return
  Widget get _horizontalSpacer {
    switch (spacing) {
      case OptimusStackSpacing.spacing0:
        return const _HorizontalSpacer(spacing: spacing0);
      case OptimusStackSpacing.spacing25:
        return const _HorizontalSpacer(spacing: spacing25);
      case OptimusStackSpacing.spacing50:
        return const _HorizontalSpacer(spacing: spacing50);
      case OptimusStackSpacing.spacing100:
        return const _HorizontalSpacer(spacing: spacing100);
      case OptimusStackSpacing.spacing200:
        return const _HorizontalSpacer(spacing: spacing200);
      case OptimusStackSpacing.spacing300:
        return const _HorizontalSpacer(spacing: spacing300);
      case OptimusStackSpacing.spacing400:
        return const _HorizontalSpacer(spacing: spacing400);
      case OptimusStackSpacing.spacing500:
        return const _HorizontalSpacer(spacing: spacing500);
    }
  }
}

/// Puts [item] between every item in [iterable].
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

class _VerticalSpacer extends StatelessWidget {
  const _VerticalSpacer({
    Key key,
    this.spacing,
  }) : super(key: key);

  final double spacing;

  @override
  Widget build(BuildContext context) => SizedBox(height: spacing);
}

class _HorizontalSpacer extends StatelessWidget {
  const _HorizontalSpacer({
    Key key,
    this.spacing,
  }) : super(key: key);

  final double spacing;

  @override
  Widget build(BuildContext context) => SizedBox(width: spacing);
}
