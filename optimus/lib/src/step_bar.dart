import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/stack.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/utils.dart';

/// Step-bars are used to communicate a sense of progress visually through
/// a sequence of either numbered or logical steps.
///
/// Every step-bar is composed of repeatable elements in individual steps
/// linked by either horizontal or vertical lines to convey the sense
/// of journeying through a process.
class OptimusStepBar extends StatelessWidget {
  const OptimusStepBar({
    Key key,
    @required this.type,
    @required this.layout,
    @required this.items,
    this.currentItem = 0,
    this.maxItem,
  }) : super(key: key);

  final OptimusStepBarType type;
  final Axis layout;
  final List<OptimusStepBarItem> items;
  final int currentItem;
  final int maxItem;

  // TODO(MM): use dimensions
  //final double _itemMinWidth = 112;
  final double _itemMaxWidth = 320;

  //final double _itemHeight = 66;
  //final double _spacerMinWidth = 16;
  final double _spacerHeight = 16;
  final double _spacerThickness = 1;

  OptimusStepBarItemState getState(OptimusStepBarItem item) {
    final position = items.indexOf(item);
    if (position == currentItem) {
      return OptimusStepBarItemState.active;
    }
    if (position < currentItem) {
      return OptimusStepBarItemState.completed;
    }
    if (maxItem == null || position <= maxItem) {
      return OptimusStepBarItemState.enabled;
    }
    return OptimusStepBarItemState.disabled;
  }

  @override
  Widget build(BuildContext context) => OptimusStack(
        direction: _layout(context),
        breakpoint: Breakpoint.small,
        crossAxisAlignment: layout == Axis.vertical
            ? OptimusStackAlignment.start
            : OptimusStackAlignment.center,
        children: _buildItems(items),
      );

  // TODO(MM): line color
  // ignore: missing_return
  Widget get _spacer {
    switch (layout) {
      case Axis.horizontal:
        return Expanded(
          child: Container(
            width: 16,
            height: _spacerThickness,
            color: OptimusColors.primary,
          ),
        );
      case Axis.vertical:
        return Padding(
          padding: EdgeInsets.only(
            left: _spacerLeftPadding,
            bottom: spacing100,
            top: spacing100,
          ),
          child: SizedBox(
            height: _spacerHeight,
            width: _spacerThickness,
            child: Container(
              color: OptimusColors.primary,
            ),
          ),
        );
    }
  }

  List<Widget> _buildItems(List<OptimusStepBarItem> items) =>
      (items.asMap().map((i, e) => MapEntry(i, _buildItem(e, i))).values)
          .toList()
          .intersperse(_spacer)
          .toList();

  Widget _buildItem(OptimusStepBarItem item, int index) => Flex(
        direction: layout,
        children: [
          Enabled(
            isEnabled: getState(item) != OptimusStepBarItemState.disabled,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: spacing100),
                  child: _buildIcon(item, type, index),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: spacing100,
                    right: spacing200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle.merge(
                        child: item.label,
                        style: preset200s,
                      ),
                      DefaultTextStyle.merge(
                        child: item.description,
                        style: preset200m.copyWith(
                          color: OptimusColors.neutral1000t64,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  // ignore: missing_return
  Widget _buildIcon(
    OptimusStepBarItem item,
    OptimusStepBarType type,
    int index,
  ) {
    final state = getState(item);
    switch (type) {
      case OptimusStepBarType.icon:
        return Container(
          width: _iconWrapperSize,
          height: _iconWrapperSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: state == OptimusStepBarItemState.active
                ? OptimusColors.primary500t8
                : Colors.transparent,
          ),
          child: OptimusIcon(
            iconData: state == OptimusStepBarItemState.completed
                ? OptimusIcons.done
                : item.icon,
            colorOption: _iconColor(state),
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
                    ? const BoxDecoration(
                        shape: BoxShape.circle,
                        color: OptimusColors.primary500t8,
                      )
                    : null,
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _iconBackgroundColor(state),
                ),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: preset200s.merge(
                      TextStyle(height: 1, color: _textColor(state)),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    }
  }

  Axis _layout(BuildContext context) {
    if (MediaQuery.of(context).size.width > _itemMaxWidth) {
      return layout;
    } else {
      return Axis.vertical;
    }
  }

  // ignore: missing_return
  double get _spacerLeftPadding {
    switch (type) {
      case OptimusStepBarType.icon:
        return 36;
      case OptimusStepBarType.numbered:
        return 28;
    }
  }

  // ignore: missing_return
  OptimusColorOption _iconColor(OptimusStepBarItemState state) {
    switch (state) {
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

  // ignore: missing_return
  Color _iconBackgroundColor(OptimusStepBarItemState state) {
    switch (state) {
      case OptimusStepBarItemState.completed:
        return OptimusColors.primary;
      case OptimusStepBarItemState.active:
        return OptimusColors.primary;
      case OptimusStepBarItemState.enabled:
        return OptimusColors.neutral50;
      case OptimusStepBarItemState.disabled:
        return OptimusColors.neutral50;
    }
  }

  // ignore: missing_return
  Color _textColor(OptimusStepBarItemState state) {
    switch (state) {
      case OptimusStepBarItemState.completed:
        return OptimusColors.primary;
      case OptimusStepBarItemState.active:
        return OptimusColors.neutral0;
      case OptimusStepBarItemState.enabled:
        return OptimusColors.neutral1000;
      case OptimusStepBarItemState.disabled:
        return OptimusColors.neutral1000;
    }
  }
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
    @required this.label,
    this.description,
    this.icon,
  });

  final Widget label;
  final Widget description;
  final IconData icon;
}

const _iconWrapperSize = spacing500;
