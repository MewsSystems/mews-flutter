import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

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

  String _getIndicatorText(OptimusProgressIndicatorItem item) =>
      (widget.items.indexOf(item) + 1).toString();

  Axis get _effectiveLayout =>
      MediaQuery.sizeOf(context).screenBreakpoint.index > Breakpoint.small.index
          ? widget.layout
          : Axis.vertical;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        // TODO(witwash): vertical layout
        builder: (context, constraints) {
          final effectiveWidth = constraints.maxWidth - tokens.spacing100 * 2;
          final itemWidth = effectiveWidth / widget.items.length;
          final firstRowHeight = tokens.sizing400;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: tokens.spacing100),
            child: SizedBox(
              width: effectiveWidth,
              child: Column(
                children: [
                  SizedBox(
                    width: constraints.maxWidth -
                        itemWidth / 2 -
                        tokens.sizing300 *
                            2, // TODO(witwash): describe, remove magic
                    height: firstRowHeight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: widget.items
                          .intersperseWith(
                            itemBuilder: (item) => ProgressIndicatorItem(
                              state: _getItemState(item),
                              text: _getIndicatorText(item),
                            ),
                            separatorBuilder: (_, nextItem) => Expanded(
                              child: ProgressIndicatorSpacer(
                                nextItemState: _getItemState(nextItem),
                                layout: _effectiveLayout,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight - firstRowHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.items
                          .map(
                            (item) => SizedBox(
                              width: itemWidth,
                              child: ProgressIndicatorDescription(
                                label: item.label,
                                description: item.description,
                                state: _getItemState(item),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
