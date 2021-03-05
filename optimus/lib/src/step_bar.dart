import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/breakpoint.dart';
import 'package:optimus/src/colors/color_options.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/icon.dart';
import 'package:optimus/src/spacing.dart';
import 'package:optimus/src/stack.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/utils.dart';

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
  /// All the steps after [maxItem] will be disabled. If [null] all the steps
  /// are enabled.
  final int? maxItem;

  @override
  _OptimusStepBarState createState() => _OptimusStepBarState();
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
    if (widget.maxItem == null || position <= widget.maxItem!) {
      return OptimusStepBarItemState.enabled;
    }
    return OptimusStepBarItemState.disabled;
  }

  // ignore: missing_return
  Widget get _spacer {
    switch (_effectiveLayout) {
      case Axis.horizontal:
        return Flexible(
          child: Container(
            constraints: const BoxConstraints(minWidth: _spacerMinWidth),
            height: _spacerThickness,
            color: theme.colors.primary,
          ),
        );
      case Axis.vertical:
        return Padding(
          padding: const EdgeInsets.only(
            left: _verticalSpacerLeftPadding,
            bottom: spacing100,
            top: spacing100,
          ),
          child: SizedBox(
            height: _spacerHeight,
            width: _spacerThickness,
            child: Container(color: theme.colors.primary),
          ),
        );
    }
  }

  List<Widget> _buildItems(List<OptimusStepBarItem> items, double maxWidth) =>
      items.map((i) => _buildItem(i, maxWidth)).intersperse(_spacer).toList();

  Widget _buildItem(OptimusStepBarItem item, double maxWidth) => ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: min(_itemMaxWidth, maxWidth),
          minWidth: _itemMinWidth,
        ),
        child: Enabled(
          isEnabled: _getItemState(item) != OptimusStepBarItemState.disabled,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: _itemLeftPadding),
              _buildIcon(item),
              const SizedBox(width: spacing100),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle.merge(
                      style: preset200s,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      child: item.label,
                    ),
                    if (item.description != null)
                      DefaultTextStyle.merge(
                        overflow: TextOverflow.ellipsis,
                        style: preset200m.copyWith(
                          color: theme.isDark
                              ? theme.colors.neutral0t64
                              : theme.colors.neutral1000t64,
                        ),
                        maxLines: 1,
                        child: item.description!,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: spacing200),
            ],
          ),
        ),
      );

  // ignore: missing_return
  Widget _buildIcon(OptimusStepBarItem item) {
    final state = _getItemState(item);
    switch (widget.type) {
      case OptimusStepBarType.icon:
        return Container(
          width: _iconWrapperSize,
          height: _iconWrapperSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: state == OptimusStepBarItemState.active
                ? theme.colors.primary500t8
                : Colors.transparent,
          ),
          child: OptimusIcon(
            iconData: state == OptimusStepBarItemState.completed
                ? OptimusIcons.done
                : item.icon,
            colorOption: state.iconColor,
          ),
        );
      case OptimusStepBarType.numbered:
        if (state == OptimusStepBarItemState.completed) {
          return const SizedBox(
            width: _iconWrapperSize,
            height: _iconWrapperSize,
            child: OptimusIcon(
              iconData: OptimusIcons.done,
              colorOption: OptimusColorOption.primary,
            ),
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: _iconWrapperSize,
                height: _iconWrapperSize,
                decoration: state == OptimusStepBarItemState.active
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colors.primary500t8,
                      )
                    : null,
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.iconBackgroundColor(theme),
                ),
                child: Center(
                  child: Text(
                    (widget.items.indexOf(item) + 1).toString(),
                    style: preset200s.merge(
                      TextStyle(height: 1, color: state.textColor(theme)),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    }
  }

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

const _iconWrapperSize = spacing500;
const _itemLeftPadding = spacing100;
const _verticalSpacerLeftPadding = _iconWrapperSize / 2 + _itemLeftPadding;
const double _spacerHeight = 16;
const double _spacerThickness = 1;
const double _itemMinWidth = 112;
const double _itemMaxWidth = 320;
const double _spacerMinWidth = 16;

extension on OptimusStepBarItemState {
  // ignore: missing_return
  Color iconBackgroundColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return theme.colors.primary;
      case OptimusStepBarItemState.active:
        return theme.colors.primary;
      case OptimusStepBarItemState.enabled:
        return theme.isDark ? theme.colors.neutral400 : theme.colors.neutral50;
      case OptimusStepBarItemState.disabled:
        return theme.isDark ? theme.colors.neutral400 : theme.colors.neutral50;
    }
  }

  // ignore: missing_return
  Color textColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return theme.colors.primary;
      case OptimusStepBarItemState.active:
        return theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0;
      case OptimusStepBarItemState.enabled:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;
      case OptimusStepBarItemState.disabled:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;
    }
  }

  // ignore: missing_return
  OptimusColorOption get iconColor {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return OptimusColorOption.primary;
      case OptimusStepBarItemState.active:
        return OptimusColorOption.primary;
      case OptimusStepBarItemState.enabled:
        return OptimusColorOption.basic;
      case OptimusStepBarItemState.disabled:
        return OptimusColorOption.basic;
    }
  }
}
