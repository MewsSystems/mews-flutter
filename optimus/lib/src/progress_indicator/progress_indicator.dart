import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_detector.dart';

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
      Axis.horizontal => _HorizontalProgressIndicator(
          items: items,
          currentItem: currentItem,
          maxItem: maxItem,
        ),
      Axis.vertical => _VerticalProgressIndicator(
          items: items,
          currentItem: currentItem,
          maxItem: maxItem,
        )
    };
  }
}

class _HorizontalProgressIndicator extends StatelessWidget {
  const _HorizontalProgressIndicator({
    required this.items,
    required this.currentItem,
    this.maxItem,
  });

  final List<OptimusProgressIndicatorItem> items;
  final int currentItem;
  final int? maxItem;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final tokens = context.tokens;
          final effectiveWidth = constraints.maxWidth;
          final itemWidth = effectiveWidth / items.length;
          final firstRowHeight = tokens.sizing400;
          final firstRowItemSize = tokens.sizing300;
          final firstRowHorizontalPadding =
              itemWidth / 2 - firstRowItemSize / 2;

          return SizedBox(
            width: effectiveWidth,
            child: Stack(
              children: [
                if (items.length > 1)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: firstRowHorizontalPadding,
                    ),
                    child: SizedBox(
                      height: firstRowHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: items
                            .intersperseWith(
                              itemBuilder: (_) =>
                                  SizedBox(width: firstRowItemSize),
                              separatorBuilder: (_, nextItem) => Expanded(
                                child: ProgressIndicatorSpacer(
                                  nextItemState: items.getIndicatorState(
                                    item: nextItem,
                                    currentItem: currentItem,
                                    maxItem: maxItem,
                                  ),
                                  layout: Axis.horizontal,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    for (final item in items)
                      SizedBox(
                        width: itemWidth,
                        height: constraints.maxHeight,
                        child: ProgressIndicatorItem(
                          state: items.getIndicatorState(
                            item: item,
                            currentItem: currentItem,
                            maxItem: maxItem,
                          ),
                          text: items.getIndicatorText(item),
                          label: item.label,
                          description: item.description,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      );
}

class _VerticalProgressIndicator extends StatefulWidget {
  const _VerticalProgressIndicator({
    required this.items,
    required this.currentItem,
    this.maxItem,
  });

  final List<OptimusProgressIndicatorItem> items;
  final int currentItem;
  final int? maxItem;

  @override
  State<_VerticalProgressIndicator> createState() =>
      _VerticalProgressIndicatorState();
}

class _VerticalProgressIndicatorState extends State<_VerticalProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightFactor;
  final CurveTween _heightFactorTween = CurveTween(curve: Curves.easeIn);

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _animationController.drive(_heightFactorTween);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
    });
  }

  OptimusProgressIndicatorItem get _currentItem =>
      widget.items[widget.currentItem];

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _animationController.isDismissed;
    final items = widget.items;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .intersperseWith(
                  itemBuilder: (item) => ProgressIndicatorItem(
                    state: items.getIndicatorState(
                      item: item,
                      currentItem: widget.currentItem,
                      maxItem: widget.maxItem,
                    ),
                    text: items.getIndicatorText(item),
                    label: item.label,
                    description: item.description,
                    axis: Axis.vertical,
                  ),
                  separatorBuilder: (_, nextItem) => ProgressIndicatorSpacer(
                    nextItemState: items.getIndicatorState(
                      item: nextItem,
                      currentItem: widget.currentItem,
                      maxItem: widget.maxItem,
                    ),
                    layout: Axis.vertical,
                  ),
                )
                .skip(1) // the first one is already in the header
                .toList(),
          ),
        ),
      ),
    );

    final headerItem = _isExpanded ? widget.items.first : _currentItem;

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (context, child) => Container(
        clipBehavior: Clip.none,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AllowMultipleRawGestureDetector(
              onTap: _handleTap,
              child: ProgressIndicatorItem(
                state: widget.items.getIndicatorState(
                  item: headerItem,
                  currentItem: widget.currentItem,
                  maxItem: widget.maxItem,
                ),
                text: widget.items.getIndicatorText(headerItem),
                label: headerItem.label,
                description: headerItem.description,
                axis: Axis.vertical,
              ),
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                heightFactor: _heightFactor.value,
                child: child,
              ),
            ),
          ],
        ),
      ),
      child: result,
    );
  }
}

extension on List<OptimusProgressIndicatorItem> {
  String getIndicatorText(OptimusProgressIndicatorItem item) =>
      (indexOf(item) + 1).toString();

  OptimusProgressIndicatorItemState getIndicatorState({
    required OptimusProgressIndicatorItem item,
    required int currentItem,
    int? maxItem,
  }) {
    final position = indexOf(item);
    if (position == currentItem) {
      return OptimusProgressIndicatorItemState.active;
    }
    if (position < currentItem) {
      return OptimusProgressIndicatorItemState.completed;
    }

    return maxItem == null || position <= maxItem
        ? OptimusProgressIndicatorItemState.enabled
        : OptimusProgressIndicatorItemState.disabled;
  }
}

const Duration _kExpand = Duration(milliseconds: 200);
