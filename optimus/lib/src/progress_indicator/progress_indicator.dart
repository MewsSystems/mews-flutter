import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/progress_indicator/common.dart';

/// Step-bars are used to communicate a sense of progress visually through
/// a sequence of either numbered or logical steps.
///
/// Every step-bar is composed of repeatable elements in individual steps
/// linked by either horizontal or vertical lines to convey the sense
/// of journeying through a process.
class OptimusProgressIndicator extends StatefulWidget {
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
  State<OptimusProgressIndicator> createState() =>
      _OptimusProgressIndicatorState();
}

class _OptimusProgressIndicatorState extends State<OptimusProgressIndicator>
    with ThemeGetter {
  OptimusProgressIndicatorItemState _getItemState(
    OptimusProgressIndicatorItem item,
  ) {
    final position = widget.items.indexOf(item);
    if (position == widget.currentItem) {
      return OptimusProgressIndicatorItemState.active;
    }
    if (position < widget.currentItem) {
      return OptimusProgressIndicatorItemState.completed;
    }

    final maxItem = widget.maxItem;

    return maxItem == null || position <= maxItem
        ? OptimusProgressIndicatorItemState.enabled
        : OptimusProgressIndicatorItemState.disabled;
  }

  String _indicatorText(OptimusProgressIndicatorItem item) =>
      (widget.items.indexOf(item) + 1).toString();

  List<Widget> _buildItems(
    List<OptimusProgressIndicatorItem> items,
    double maxWidth,
  ) =>
      items
          .intersperseWith(
            itemBuilder: (item) => Padding(
              padding: EdgeInsets.symmetric(horizontal: tokens.spacing100),
              child: ProgressIndicatorItem(
                state: _getItemState(item),
                indicatorText: _indicatorText(item),
              ),
            ),
            separatorBuilder: (_, nextItem) => Expanded(
              child: ProgressIndicatorSpacer(
                nextItemState: _getItemState(nextItem),
                layout: _effectiveLayout,
              ),
            ),
          )
          .toList();
  List<Widget> _buildDescriptions(
    List<OptimusProgressIndicatorItem> items,
    double width,
  ) =>
      items
          .map(
            (item) => SizedBox(
              width: width,
              child: ProgressIndicatorDescription(
                label: item.label,
                description: item.description,
              ),
            ),
          )
          .toList();

  Axis get _effectiveLayout =>
      MediaQuery.sizeOf(context).screenBreakpoint.index > Breakpoint.small.index
          ? widget.layout
          : Axis.vertical;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final totalSpacerWidth = (widget.items.length - 1) * tokens.sizing200;
          final totalFreeSpace =
              (constraints.maxWidth - totalSpacerWidth) / widget.items.length;
          final maxItemWidth = max(totalFreeSpace, itemMinWidth);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: tokens.spacing100),
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: tokens.sizing400,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildItems(widget.items, maxItemWidth),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight - tokens.sizing400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _buildDescriptions(widget.items, maxItemWidth),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
