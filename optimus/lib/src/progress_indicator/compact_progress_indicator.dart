import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/typography.dart';

/// The compact version of the OptimusProgressIndicator that is using a
/// modified vertical layout that can be expanded and collapsed.
class OptimusCompactProgressIndicator extends StatefulWidget {
  const OptimusCompactProgressIndicator({
    super.key,
    required this.items,
    required this.currentItem,
    this.maxItem,
    this.rootOverlay = false,
  });

  final List<OptimusProgressIndicatorItem> items;
  final int currentItem;
  final int? maxItem;
  final bool rootOverlay;

  @override
  State<OptimusCompactProgressIndicator> createState() =>
      _OptimusCompactProgressIndicatorState();
}

class _OptimusCompactProgressIndicatorState
    extends State<OptimusCompactProgressIndicator>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _anchorKey = GlobalKey();
  late final _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    reverseDuration: const Duration(milliseconds: 100),
    vsync: this,
  );

  bool _expanded = false;

  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OptimusCompactProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _overlayEntry?.markNeedsBuild();
    });
  }

  void _handleExpand() {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry().also((it) {
      Overlay.of(context, rootOverlay: widget.rootOverlay).insert(it);
      setState(() => _expanded = true);
    });
  }

  void _handleCollapse() {
    final overlay = _overlayEntry;

    if (overlay != null) {
      _animationController.reverse().then((value) {
        overlay
          ..remove()
          ..dispose();
        setState(() => _expanded = false);
        _overlayEntry = null;
      });
    }
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (context) => IgnorePointer(
          ignoring: _animationController.isAnimating,
          child: GestureDetector(
            onTap: _handleCollapse,
            child: Material(
              color: Colors.transparent,
              child: _ProgressIndicatorData(
                items: widget.items,
                currentItemIndex: widget.currentItem,
                maxItem: widget.maxItem,
                child: _ExpandedCompactProgressIndicator(
                  controller: _animationController,
                  targetKey: _anchorKey,
                  layerLink: _layerLink,
                  rootOverlay: widget.rootOverlay,
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => _ProgressIndicatorData(
        items: widget.items,
        currentItemIndex: widget.currentItem,
        maxItem: widget.maxItem,
        child: GestureDetector(
          onTap: _handleExpand,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: _CollapsedCompactProgressIndicator(
              key: _anchorKey,
              showShadow: !_expanded,
            ),
          ),
        ),
      );
}

class _CollapsedCompactProgressIndicator extends StatelessWidget {
  const _CollapsedCompactProgressIndicator({
    super.key,
    this.showShadow = true,
  });

  final bool showShadow;

  List<BoxShadow>? _getShadow(OptimusTokens tokens) =>
      showShadow ? tokens.shadow100 : null;

  @override
  Widget build(BuildContext context) {
    final data = _ProgressIndicatorData.of(context);
    final tokens = context.tokens;

    return data != null
        ? Container(
            height: _itemHeight,
            constraints: const BoxConstraints(minHeight: _itemHeight),
            decoration: BoxDecoration(
              color: tokens.borderStaticInverse,
              boxShadow: _getShadow(context.tokens),
              borderRadius: BorderRadius.all(tokens.borderRadius50),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _CompactProgressIndicatorItem(
                    text: (data.currentItemIndex + 1).toString(),
                  ),
                ),
                _CompactProgressIndicatorElement(
                  currentStep: data.currentItemIndex,
                  maxSteps: data.maxItem,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _CompactProgressIndicatorItem extends StatelessWidget {
  const _CompactProgressIndicatorItem({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final data = _ProgressIndicatorData.of(context);

    return data != null
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing100,
              vertical: tokens.spacing100,
            ),
            child: ProgressIndicatorItem(
              // item: data.items[data.currentItem],
              // maxWidth: double.infinity,
              state: OptimusProgressIndicatorItemState.active,
              text: text,
              label: data.currentItem.label,
              description: data.currentItem.description,
            ),
          )
        : const SizedBox.shrink();
  }
}

class _CompactProgressIndicatorElement extends StatelessWidget {
  const _CompactProgressIndicatorElement({
    required this.currentStep,
    required this.maxSteps,
  });

  final int currentStep;
  final int? maxSteps;

  String get text =>
      maxSteps == null ? '$currentStep' : '$currentStep/$maxSteps';

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SizedBox(
      width: 90, // TODO(witwash): check with design
      child: Padding(
        padding: EdgeInsets.only(right: tokens.spacing200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OptimusTypography(
              resolveStyle: (_) => tokens.bodyMediumStrong
                  .copyWith(overflow: TextOverflow.ellipsis),
              maxLines: 1,
              child: Text(text),
            ),
            SizedBox(width: tokens.spacing50),
            const OptimusIcon(iconData: OptimusIcons.chevron_up),
          ],
        ),
      ),
    );
  }
}

class _ExpandedCompactProgressIndicator extends StatefulWidget {
  const _ExpandedCompactProgressIndicator({
    required this.layerLink,
    required this.controller,
    required this.targetKey,
    this.rootOverlay = false,
  });

  final LayerLink layerLink;

  final AnimationController controller;
  final GlobalKey targetKey;
  final bool rootOverlay;

  @override
  State<_ExpandedCompactProgressIndicator> createState() =>
      _ExpandedCompactProgressIndicatorState();
}

class _ExpandedCompactProgressIndicatorState
    extends State<_ExpandedCompactProgressIndicator> with ThemeGetter {
  late Rect _targetRect;
  late Size? _overlaySize;

  @override
  void initState() {
    super.initState();
    _targetRect = _calculateTargetRect();
    _overlaySize = _getOverlaySize();
    widget.controller.forward();
  }

  @override
  void didUpdateWidget(covariant _ExpandedCompactProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(_updateRect);
  }

  void _updateRect(dynamic _) {
    if (!mounted) return;
    final newRect = _calculateTargetRect();
    if (newRect != _targetRect) {
      final newSize = _getOverlaySize();
      setState(() {
        _targetRect = newRect;
        _overlaySize = newSize;
      });
    }
  }

  Rect _calculateTargetRect() {
    final renderObject = widget.targetKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return Rect.zero;

    final size = renderObject.size;

    return renderObject.localToGlobal(Offset.zero, ancestor: _getOverlay()) &
        size;
  }

  RenderBox? _getOverlay() =>
      Overlay.of(context, rootOverlay: widget.rootOverlay)
          .context
          .findRenderObject() as RenderBox?;

  Size? _getOverlaySize() => _getOverlay()?.size;

  double get _targetWidth => _targetRect.size.width;

  double get _targetHeight => _targetRect.size.height;

  bool get _expandToTop => _top > _bottom;

  double get _bottom => _overlayHeight - _targetRect.bottom;

  double get _top => _targetRect.top;

  double get _overlayHeight => _overlaySize?.height ?? 0;

  @override
  Widget build(BuildContext context) {
    final data = _ProgressIndicatorData.of(context);

    return data != null
        ? CompositedTransformFollower(
            link: widget.layerLink,
            offset: _expandToTop ? Offset(0, _targetHeight) : Offset.zero,
            child: Stack(
              children: [
                if (_expandToTop)
                  _ReverseAnimatedProgressIndicator(
                    controller: widget.controller,
                    width: _targetWidth,
                  )
                else
                  _AnimatedProgressIndicator(
                    controller: widget.controller,
                    itemsCount: data.items.length,
                    width: _targetWidth,
                  ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _ReverseAnimatedProgressIndicator extends StatefulWidget {
  const _ReverseAnimatedProgressIndicator({
    required this.controller,
    required this.width,
  });

  final AnimationController controller;
  final double width;

  @override
  State<_ReverseAnimatedProgressIndicator> createState() =>
      _ReverseAnimatedProgressIndicatorState();
}

class _ReverseAnimatedProgressIndicatorState
    extends State<_ReverseAnimatedProgressIndicator> {
  late final Animation<double> _reversedAnimation;

  late final Animatable<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _reversedAnimation = Tween(begin: 0.0, end: 0.0).animate(widget.controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final data = _ProgressIndicatorData.of(context);

    return data != null
        ? SlideTransition(
            position: _reversedAnimation.drive(_slideAnimation),
            child: _AnimatedProgressIndicator(
              controller: widget.controller,
              itemsCount: data.items.length,
              width: widget.width,
            ),
          )
        : const SizedBox.shrink();
  }
}

class _AnimatedProgressIndicator extends StatefulWidget {
  const _AnimatedProgressIndicator({
    required this.controller,
    required this.itemsCount,
    required this.width,
  });

  final AnimationController controller;
  final int itemsCount;
  final double width;

  @override
  State<_AnimatedProgressIndicator> createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState
    extends State<_AnimatedProgressIndicator> {
  final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.fastOutSlowIn);
  final Animatable<double> _halfTween = Tween<double>(begin: 0, end: 0.5);

  late final Animation<double> _iconTurns;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animation =
        Tween(begin: _animationOffset, end: 1.0).animate(widget.controller);
    _iconTurns = widget.controller.drive(_halfTween.chain(_easeInTween));
  }

  double get _animationOffset => 1 / widget.itemsCount;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final data = _ProgressIndicatorData.of(context);

    return data != null
        ? SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1,
            child: Container(
              width: widget.width,
              decoration: BoxDecoration(
                color: tokens.backgroundStaticFlat,
                boxShadow: context.tokens.shadow100,
                borderRadius: BorderRadius.all(tokens.borderRadius50),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: tokens.spacing100,
                  vertical: tokens.spacing150,
                ),
                child: Stack(
                  children: [
                    OptimusProgressIndicator(
                      layout: Axis.vertical,
                      items: data.items,
                      currentItem: data.currentItemIndex,
                      maxItem: data.maxItem,
                    ),
                    Positioned(
                      top: tokens.spacing100,
                      right: tokens.spacing100,
                      child: RotationTransition(
                        turns: _iconTurns,
                        child: const OptimusIcon(
                          iconData: OptimusIcons.chevron_up,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _ProgressIndicatorData extends InheritedWidget {
  const _ProgressIndicatorData({
    required this.items,
    required this.currentItemIndex,
    required this.maxItem,
    required super.child,
  });

  final List<OptimusProgressIndicatorItem> items;
  final int currentItemIndex;
  final int? maxItem;

  OptimusProgressIndicatorItem get currentItem => items[currentItemIndex];

  static _ProgressIndicatorData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ProgressIndicatorData>();

  @override
  bool updateShouldNotify(_ProgressIndicatorData oldWidget) => true;
}

const double _itemHeight = 66; // TODO(witwash): check with design
