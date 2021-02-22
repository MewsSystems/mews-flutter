import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/constants.dart';
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
  }) : super(key: key);

  final OptimusStepBarType type;
  final Axis layout;
  final List<OptimusStepBarItem> items;

  final double _itemMinWidth = 112;
  final double _itemMaxWidth = 320;
  final double _itemHeight = 66;
  final double _spacerMinWidth = 16;
  final double _spacerHeight = 16;
  final double _spacerThickness = 1;

  @override
  Widget build(BuildContext context) => OptimusStack(
        direction: layout,
        breakpoint: Breakpoint.small,
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
        return SizedBox(
          height: _spacerHeight,
          width: _spacerThickness,
          child: Container(
            color: OptimusColors.primary,
          ),
        );
    }
  }

  List<Widget> _buildItems(List<OptimusStepBarItem> items) =>
      (items.asMap().map((i, e) => MapEntry(i, _buildItem(e, i))).values)
          .toList()
          .intersperse(_spacer)
          .toList();

  // TODO(MM): build items
  Widget _buildItem(OptimusStepBarItem item, int index) => Flex(
        direction: layout,
        children: [
          Opacity(
            opacity: item.state == OptimusStepBarItemState.disabled
                ? OpacityValue.disabled
                : OpacityValue.enabled,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: spacing200),
                  child: _buildIcon(item, type, index),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: spacing200,
                    right: spacing200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle.merge(
                        child: item.label,
                        style: preset300m,
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
    switch (type) {
      case OptimusStepBarType.icon:
        return OptimusIcon(
          iconData: item.icon,
          colorOption: OptimusColorOption.primary,
        );
      case OptimusStepBarType.numbered:
        if (item.state == OptimusStepBarItemState.completed) {
          return const OptimusIcon(
            iconData: OptimusIcons.done,
            colorOption: OptimusColorOption.primary,
          );
        } else {
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _iconBackgroundColor(item.state),
            ),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: preset200s.merge(
                  TextStyle(
                    height: 1,
                    color: _textColor(item.state),
                  ),
                ),
              ),
            ),
          );
        }
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
  const OptimusStepBarItem(
      {this.label, this.description, this.icon, this.state});

  final Widget label;
  final Widget description;
  final IconData icon;
  final OptimusStepBarItemState state;
}
