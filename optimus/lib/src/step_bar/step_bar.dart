import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/step_bar/step_bar_item.dart';

/// Step-bars are used to communicate a sense of progress visually through
/// a sequence of either numbered or logical steps.
///
/// Every step-bar is composed of repeatable elements in individual steps
/// linked by either horizontal or vertical lines to convey the sense
/// of journeying through a process.
class OptimusStepBar extends StatefulWidget {
  const OptimusStepBar({
    Key? key,
    required this.type,
    required this.layout,
    required this.items,
    this.currentItem = 0,
    this.maxItem,
  }) : super(key: key);

  /// Type of the step bar.
  final OptimusStepBarType type;

  /// Whether the step bar would be laid out horizontally or vertically.
  ///
  /// For screen size of [Breakpoint.extraSmall] and [Breakpoint.small]
  /// this parameter is ignored and [Axis.vertical] is always used.
  final Axis layout;

  /// Step bar items.
  final List<OptimusStepBarItem> items;

  /// Current (active) step.
  final int currentItem;

  /// The maximum enabled step.
  ///
  /// All the steps after [maxItem] will be disabled. If `null` all the steps
  /// are enabled.
  final int? maxItem;

  @override
  State<OptimusStepBar> createState() => _OptimusStepBarState();
}

class _OptimusStepBarState extends State<OptimusStepBar> with ThemeGetter {
  OptimusStepBarItemState _getItemState(OptimusStepBarItem item) {
    final position = widget.items.indexOf(item);
    if (position == widget.currentItem) {
      return OptimusStepBarItemState.active;
    }
    if (position < widget.currentItem) {
      return OptimusStepBarItemState.completed;
    }

    final maxItem = widget.maxItem;
    if (maxItem == null || position <= maxItem) {
      return OptimusStepBarItemState.enabled;
    }

    return OptimusStepBarItemState.disabled;
  }

  String _indicatorText(OptimusStepBarItem item) =>
      (widget.items.indexOf(item) + 1).toString();

  List<Widget> _buildItems(List<OptimusStepBarItem> items, double maxWidth) =>
      items
          .intersperseWith(
            itemBuilder: (item) => StepBarItem(
              maxWidth: maxWidth,
              item: item,
              state: _getItemState(item),
              type: widget.type,
              indicatorText: _indicatorText(item),
            ),
            separatorBuilder: (_, nextItem) => StepBarSpacer(
              nextItemState: _getItemState(nextItem),
              layout: _effectiveLayout,
            ),
          )
          .toList();

  Axis get _effectiveLayout {
    if (MediaQuery.of(context).screenBreakpoint.index >
        Breakpoint.small.index) {
      return widget.layout;
    } else {
      return Axis.vertical;
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final totalSpacerWidth = (widget.items.length - 1) * _spacerMinWidth;
          final totalFreeSpace =
              (constraints.maxWidth - totalSpacerWidth) / widget.items.length;
          final maxItemWidth = max(totalFreeSpace, _itemMinWidth);

          return OptimusStack(
            mainAxisSize: _effectiveLayout == Axis.vertical
                ? MainAxisSize.min
                : MainAxisSize.max,
            direction: _effectiveLayout,
            crossAxisAlignment: _effectiveLayout == Axis.vertical
                ? OptimusStackAlignment.start
                : OptimusStackAlignment.center,
            children: _buildItems(widget.items, maxItemWidth),
          );
        },
      );
}

enum OptimusStepBarType { icon, numbered }

/// Both types of step have dedicated states. State is shown through a visual
/// change in the step indicator and in the divider between steps.
/// All of this forms a visual distinction between the finished and unfinished
/// part of a process.
enum OptimusStepBarItemState {
  /// The step is finished. The icon is always changed to a check icon.
  completed,

  /// The step is active and unfinished.
  active,

  /// The step is inactive and unfinished.
  enabled,

  /// The step is disabled and unavailable.
  disabled,
}

class OptimusStepBarItem {
  const OptimusStepBarItem({
    required this.label,
    this.description,
    required this.icon,
  });

  final Widget label;
  final Widget? description;
  final IconData icon;
}

const double _itemMinWidth = 112;
const double _spacerMinWidth = 16;
