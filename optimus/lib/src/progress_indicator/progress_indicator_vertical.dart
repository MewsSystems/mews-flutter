import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/common/gesture_detector.dart';
import 'package:optimus/src/progress_indicator/progress_indicator_item.dart';

class VerticalProgressIndicator extends StatefulWidget {
  const VerticalProgressIndicator({
    super.key,
    required this.items,
    required this.currentItem,
    this.maxItem,
  });

  final List<OptimusProgressIndicatorItem> items;
  final int currentItem;
  final int? maxItem;

  @override
  State<VerticalProgressIndicator> createState() =>
      _VerticalProgressIndicatorState();
}

class _VerticalProgressIndicatorState extends State<VerticalProgressIndicator>
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
      PageStorage.maybeOf(context)?.writeState(
        context,
        _isExpanded,
      ); // TODO(witwash): add loading from the saved state
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
            CustomRawGestureDetector(
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

const Duration _kExpand = Duration(milliseconds: 200);
