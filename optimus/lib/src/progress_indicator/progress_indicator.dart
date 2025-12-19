import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_detector.dart';
import 'package:optimus/src/common/semantics.dart';
import 'package:optimus/src/progress_indicator/common.dart';

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
    final effectiveLayout =
        MediaQuery.sizeOf(context).screenBreakpoint.index >
            Breakpoint.small.index
        ? layout
        : Axis.vertical;

    return switch (effectiveLayout) {
      .horizontal => _HorizontalProgressIndicator(
        items: items,
        currentItem: currentItem,
        maxItem: maxItem,
      ),
      .vertical => _VerticalProgressIndicator(
        items: items,
        currentItem: currentItem,
        maxItem: maxItem,
      ),
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
      final effectiveWidth = constraints.maxWidth;
      final itemWidth = effectiveWidth / items.length;
      final indicatorHeight = context.indicatorHeight;
      final indicatorWidth = context.indicatorWidth;
      final textRowHeight = items.any((element) => element.description != null)
          ? context.titleSize + context.descriptionSize
          : context.titleSize;
      final indicatorRowHorizontalPadding = itemWidth / 2 - indicatorWidth / 2;
      final height = indicatorHeight + textRowHeight;

      return SizedBox(
        width: effectiveWidth,
        height: height,
        child: Stack(
          children: [
            if (items.length > 1)
              _SpacerLayer(
                horizontalPadding: indicatorRowHorizontalPadding,
                itemHeight: indicatorHeight,
                children: items
                    .intersperseWith(
                      itemBuilder: (_) =>
                          SizedBox(width: indicatorWidth).excludeSemantics(),
                      separatorBuilder: (_, nextItem) => Expanded(
                        child: ProgressIndicatorSpacer(
                          layout: .horizontal,
                          nextItemState: items.getIndicatorState(
                            item: nextItem,
                            currentItem: currentItem,
                            maxItem: maxItem,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            Row(
              children: items
                  .map(
                    (item) => SizedBox(
                      width: itemWidth,
                      height: constraints.maxHeight,
                      child: ProgressIndicatorItem(
                        index: items.getIndex(item),
                        text: item.text,
                        description: item.description,
                        state: items.getIndicatorState(
                          item: item,
                          currentItem: currentItem,
                          maxItem: maxItem,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    },
  );
}

class _SpacerLayer extends StatelessWidget {
  const _SpacerLayer({
    required this.horizontalPadding,
    required this.itemHeight,
    required this.children,
  });

  final double horizontalPadding;
  final double itemHeight;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: .symmetric(horizontal: horizontalPadding),
    child: SizedBox(
      height: itemHeight,
      child: Row(crossAxisAlignment: .center, children: children),
    ),
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
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
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
        _animationController.reverse().then<void>((_) => _handleReverse());
      }
    });
  }

  void _handleReverse() {
    if (!mounted) return;
    setState(() {
      // Rebuild without children.
    });
  }

  OptimusProgressIndicatorItem get _currentItem =>
      widget.items[widget.currentItem];

  OptimusProgressIndicatorItemState _getIndicatorState(
    OptimusProgressIndicatorItem item,
  ) => widget.items.getIndicatorState(
    item: item,
    currentItem: widget.currentItem,
    maxItem: widget.maxItem,
  );

  int get _itemsCount => widget.maxItem ?? widget.items.length;

  @override
  Widget build(BuildContext context) {
    final bool isClosed = !_isExpanded && _animationController.isDismissed;
    final items = widget.items;
    final headerItem = _isExpanded ? items.first : _currentItem;

    final Widget result = Offstage(
      offstage: isClosed,
      child: AllowMultipleRawGestureDetector(
        onTap: _handleTap,
        child: Column(
          crossAxisAlignment: .start,
          children: items
              .intersperseWith(
                itemBuilder: (item) => ProgressIndicatorItem(
                  state: _getIndicatorState(item),
                  index: items.getIndex(item),
                  text: item.text,
                  description: item.description,
                  itemsCount: _itemsCount,
                  axis: .vertical,
                ),
                separatorBuilder: (_, nextItem) => ProgressIndicatorSpacer(
                  nextItemState: _getIndicatorState(nextItem),
                  layout: .vertical,
                ),
              )
              .skip(1) // the first one is already in the header
              .toList(),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (_, child) => Container(
        clipBehavior: .none,
        child: Column(
          mainAxisSize: .min,
          children: <Widget>[
            AllowMultipleRawGestureDetector(
              onTap: _handleTap,
              child: ProgressIndicatorItem(
                state: _getIndicatorState(headerItem),
                index: items.getIndex(headerItem),
                text: headerItem.text,
                description: headerItem.description,
                itemsCount: _itemsCount,
                axis: .vertical,
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
  String getIndex(OptimusProgressIndicatorItem item) =>
      (indexOf(item) + 1).toString();

  OptimusProgressIndicatorItemState getIndicatorState({
    required OptimusProgressIndicatorItem item,
    required int currentItem,
    int? maxItem,
  }) {
    final position = indexOf(item);
    if (position == currentItem) {
      return .active;
    }
    if (position < currentItem) {
      return .completed;
    }

    return maxItem == null || position <= maxItem ? .enabled : .disabled;
  }
}
