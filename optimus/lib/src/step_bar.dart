import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

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

  List<Widget> _buildItems(List<OptimusStepBarItem> items, double maxWidth) =>
      items
          .intersperseWith(
            itemBuilder: (item) => _buildItem(item, maxWidth),
            separatorBuilder: (_, nextItem) => _buildSpacer(nextItem),
          )
          .toList();

  Widget _buildItem(OptimusStepBarItem item, double maxWidth) {
    final description = item.description;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: min(_itemMaxWidth, maxWidth),
        minWidth: _itemMinWidth,
      ),
      child: OptimusEnabled(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptimusTypography(
                    resolveStyle: (_) =>
                        preset200b.copyWith(overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                    child: item.label,
                  ),
                  if (description != null)
                    OptimusTypography(
                      resolveStyle: (_) => preset200s.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: theme.isDark
                            ? theme.colors.neutral0t64
                            : theme.colors.neutral1000t64,
                      ),
                      maxLines: 1,
                      child: description,
                    ),
                ],
              ),
            ),
            const SizedBox(width: spacing200),
          ],
        ),
      ),
    );
  }

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
              colorOption: OptimusIconColorOption.primary,
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
                    style: preset200b.merge(
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

  Widget _buildSpacer(OptimusStepBarItem item) {
    final enabled = _getItemState(item).isAccessible;
    final color = enabled ? theme.colors.primary : theme.colors.neutral1000t32;
    switch (_effectiveLayout) {
      case Axis.horizontal:
        return Flexible(
          child: Container(
            constraints: const BoxConstraints(minWidth: _spacerMinWidth),
            height: _spacerThickness,
            color: color,
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
            child: Container(color: color),
          ),
        );
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
  Color iconBackgroundColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return theme.colors.primary;
      case OptimusStepBarItemState.active:
        return theme.colors.primary;
      case OptimusStepBarItemState.enabled:
        return theme.isDark
            ? theme.colors.neutral500t40
            : theme.colors.neutral50;
      case OptimusStepBarItemState.disabled:
        return theme.isDark
            ? theme.colors.neutral500t40
            : theme.colors.neutral50;
    }
  }

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

  OptimusIconColorOption get iconColor {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return OptimusIconColorOption.primary;
      case OptimusStepBarItemState.active:
        return OptimusIconColorOption.primary;
      case OptimusStepBarItemState.enabled:
        return OptimusIconColorOption.basic;
      case OptimusStepBarItemState.disabled:
        return OptimusIconColorOption.basic;
    }
  }

  bool get isAccessible =>
      this == OptimusStepBarItemState.completed ||
      this == OptimusStepBarItemState.active;
}
