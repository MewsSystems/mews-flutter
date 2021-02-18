import 'package:flutter/cupertino.dart';
import 'package:optimus/optimus.dart';
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

  final StepBarType type;
  final Axis layout;
  final List<StepBarItem> items;

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
        return ConstrainedBox(
          constraints: BoxConstraints(minWidth: _spacerMinWidth),
          child: Container(
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

  List<Widget> _buildItems(List<StepBarItem> items) =>
      items.map(_buildItem).intersperse(_spacer).toList();

  // TODO(MM): build items
  Widget _buildItem(StepBarItem item) => IntrinsicWidth(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: _itemMinWidth,
            maxWidth: _itemMaxWidth,
          ),
          child: SizedBox(
            height: _itemHeight,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: spacing200),
                  child: OptimusIcon(
                    iconData: OptimusIcons.magic,
                    colorOption: OptimusColorOption.primary,
                  ),
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
        ),
      );
}

enum StepBarType { icon, numbered }

/// Both types of step have dedicated states. State is shown through a visual
/// change in the step indicator and in the divider between steps.
/// All of this forms a visual distinction between the finished and unfinished
/// part of a process.
enum StepBarItemState {
  /// The step is finished. The icon is always changed to a check icon.
  completed,

  /// The step is active and unfinished.
  active,

  /// The step is inactive and unfinished.
  enabled,

  /// The step is disabled and unavailable.
  disabled,
}

class StepBarItem {
  const StepBarItem({this.label, this.description, this.icon, this.state});

  final Widget label;
  final Widget description;
  final IconData icon;
  final StepBarItemState state;
}
