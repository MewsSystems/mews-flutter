import 'package:flutter/material.dart';
import 'package:optimus/src/progress_indicator/progress_indicator_item.dart';

class VerticalProgressIndicator extends StatefulWidget {
  const VerticalProgressIndicator({
    super.key,
    required this.layout,
    required this.items,
    required this.currentItem,
    this.maxItem,
  });

  final Axis layout;
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
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
    // widget.onExpansionChanged?.call(_isExpanded);
  }

  OptimusProgressIndicatorItem get _currentItem =>
      widget.items[widget.currentItem];

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _animationController.isDismissed;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: const Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hidden'),
              Text('spacer'),
              Text('Item'),
              Text('spacer'),
              Text('Item'),
              Text('spacer'),
              Text('Item'),
              Text('spacer'),
              Text('Item'),
              Text('spacer'),
            ], // TODO(witwash): hidden part
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (context, child) => Container(
        clipBehavior: Clip.none,
        decoration: const ShapeDecoration(
          shape: Border(
            top: BorderSide(color: Colors.transparent),
            bottom: BorderSide(color: Colors.transparent),
          ),
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(onTap: _handleTap, child: const Text('Item')),
            ClipRect(
              child: Align(
                alignment: Alignment.center,
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
