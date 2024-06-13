import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:optimus/optimus.dart';
import 'package:optimus/src/progress_indicator/progress_indicator_horizontal.dart';
import 'package:optimus/src/progress_indicator/progress_indicator_vertical.dart';

/// Progress indicators are used to communicate a sense of progress visually
/// through a sequence of either numbered or logical steps.
///
/// Every progress indicator is composed of repeatable elements in individual
/// steps linked by either horizontal or vertical lines to convey the sense
/// of journeying through a process.

class OptimusProgressIndicator extends StatelessWidget {
  const OptimusProgressIndicator({
    super.key,
    required this.layout,
    required this.items,
    this.currentItem = 0,
    this.maxItem,
  });

  /// Whether the step bar would be laid out horizontally or vertically.
  ///
  /// For screen size of [Breakpoint.extraSmall] and [Breakpoint.small]
  /// this parameter is ignored and [Axis.vertical] is always used.
  final Axis layout;

  /// Step bar items.
  final List<OptimusProgressIndicatorItem> items;

  /// Current (active) step.
  final int currentItem;

  /// The maximum enabled step.
  ///
  /// All the steps after [maxItem] will be disabled. If `null` all the steps
  /// are enabled.
  final int? maxItem;

  @override
  Widget build(BuildContext context) {
    final effectiveLayout = MediaQuery.sizeOf(context).screenBreakpoint.index >
            Breakpoint.small.index
        ? layout
        : Axis.vertical;

    return switch (effectiveLayout) {
      Axis.horizontal => HorizontalProgressIndicator(
          items: items,
          currentItem: currentItem,
          maxItem: maxItem,
        ),
      Axis.vertical => VerticalProgressIndicator(
          items: items,
          currentItem: currentItem,
          maxItem: maxItem,
        )
    };
  }
}
