import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// The compact version of the OptimusStepBar that is using a modified vertical
/// layout that can be expanded and collapsed.
class OptimusCompactStepBar extends StatefulWidget {
  const OptimusCompactStepBar({
    super.key,
    required this.type,
    required this.items,
    required this.currentItem,
    this.maxItem,
    this.rootOverlay = false,
  });

  final OptimusStepBarType type;
  final List<OptimusStepBarItem> items;
  final int currentItem;
  final int? maxItem;
  final bool rootOverlay;

  @override
  State<OptimusCompactStepBar> createState() => _OptimusCompactStepBarState();
}

class _OptimusCompactStepBarState extends State<OptimusCompactStepBar>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _anchorKey = GlobalKey();
  late final _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    reverseDuration: const Duration(milliseconds: 100),
    vsync: this,
  );

  bool _expanded = false;

  // ignore: dispose-fields, disposed in _collapse
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OptimusCompactStepBar oldWidget) {
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
              child: _StepBarData(
                type: widget.type,
                items: widget.items,
                currentItem: widget.currentItem,
                maxItem: widget.maxItem,
                child: _ExpandedCompactStepBar(
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
  Widget build(BuildContext context) => _StepBarData(
        type: widget.type,
        items: widget.items,
        currentItem: widget.currentItem,
        maxItem: widget.maxItem,
        child: GestureDetector(
          onTap: _handleExpand,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: _CollapsedCompactStepBar(
              key: _anchorKey,
              showShadow: !_expanded,
            ),
          ),
        ),
      );
}

class _CollapsedCompactStepBar extends StatelessWidget {
  const _CollapsedCompactStepBar({
    super.key,
    this.showShadow = true,
  });

  final bool showShadow;

  List<BoxShadow>? _getShadow(OptimusTokens tokens) =>
      showShadow ? tokens.shadow100 : null;

  @override
  Widget build(BuildContext context) {
    final data = _StepBarData.of(context);

    return data != null
        ? Container(
            height: _itemHeight,
            constraints: const BoxConstraints(minHeight: _itemHeight),
            decoration: BoxDecoration(
              color: OptimusTheme.of(context).colors.neutral0,
              boxShadow: _getShadow(context.tokens),
              borderRadius:
                  BorderRadius.circular(context.tokens.borderRadius50),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _CompactStepBarItem(
                    indicatorText: (data.currentItem + 1).toString(),
                  ),
                ),
                _CompactStepBarIndicator(
                  currentStep: data.currentItem,
                  maxSteps: data.maxItem,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _CompactStepBarItem extends StatelessWidget {
  const _CompactStepBarItem({
    required this.indicatorText,
  });

  final String indicatorText;

  @override
  Widget build(BuildContext context) {
    final data = _StepBarData.of(context);

    return data != null
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: spacing100,
              vertical: spacing100,
            ),
            child: StepBarItem(
              item: data.items[data.currentItem],
              maxWidth: double.infinity,
              state: OptimusStepBarItemState.active,
              type: data.type,
              indicatorText: indicatorText,
            ),
          )
        : const SizedBox.shrink();
  }
}

class _CompactStepBarIndicator extends StatelessWidget {
  const _CompactStepBarIndicator({
    required this.currentStep,
    required this.maxSteps,
  });

  final int currentStep;
  final int? maxSteps;

  String get text =>
      maxSteps == null ? '$currentStep' : '$currentStep/$maxSteps';

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 90,
        child: Padding(
          padding: const EdgeInsets.only(right: spacing200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OptimusTypography(
                resolveStyle: (_) =>
                    preset200s.copyWith(overflow: TextOverflow.ellipsis),
                maxLines: 1,
                child: Text(text),
              ),
              const SizedBox(width: spacing50),
              const OptimusIcon(iconData: OptimusIcons.chevron_up),
            ],
          ),
        ),
      );
}

class _ExpandedCompactStepBar extends StatefulWidget {
  const _ExpandedCompactStepBar({
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
  State<_ExpandedCompactStepBar> createState() =>
      _ExpandedCompactStepBarState();
}

class _ExpandedCompactStepBarState extends State<_ExpandedCompactStepBar>
    with ThemeGetter {
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
  void didUpdateWidget(covariant _ExpandedCompactStepBar oldWidget) {
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
    final data = _StepBarData.of(context);

    return data != null
        ? CompositedTransformFollower(
            link: widget.layerLink,
            offset: _expandToTop ? Offset(0, _targetHeight) : Offset.zero,
            child: Stack(
              children: [
                if (_expandToTop)
                  _ReverseAnimatedStepBar(
                    controller: widget.controller,
                    width: _targetWidth,
                  )
                else
                  _AnimatedStepBar(
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

class _ReverseAnimatedStepBar extends StatefulWidget {
  const _ReverseAnimatedStepBar({
    required this.controller,
    required this.width,
  });

  final AnimationController controller;
  final double width;

  @override
  State<_ReverseAnimatedStepBar> createState() =>
      _ReverseAnimatedStepBarState();
}

class _ReverseAnimatedStepBarState extends State<_ReverseAnimatedStepBar> {
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
    final data = _StepBarData.of(context);

    return data != null
        ? SlideTransition(
            position: _reversedAnimation.drive(_slideAnimation),
            child: _AnimatedStepBar(
              controller: widget.controller,
              itemsCount: data.items.length,
              width: widget.width,
            ),
          )
        : const SizedBox.shrink();
  }
}

class _AnimatedStepBar extends StatefulWidget {
  const _AnimatedStepBar({
    required this.controller,
    required this.itemsCount,
    required this.width,
  });

  final AnimationController controller;
  final int itemsCount;
  final double width;

  @override
  State<_AnimatedStepBar> createState() => _AnimatedStepBarState();
}

class _AnimatedStepBarState extends State<_AnimatedStepBar> {
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
    final data = _StepBarData.of(context);

    return data != null
        ? SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1,
            child: Container(
              width: widget.width,
              decoration: BoxDecoration(
                color: OptimusTheme.of(context).colors.neutral0,
                boxShadow: context.tokens.shadow100,
                borderRadius:
                    BorderRadius.circular(context.tokens.borderRadius50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: spacing100,
                  vertical: _verticalSpacing,
                ),
                child: Stack(
                  children: [
                    OptimusStepBar(
                      type: data.type,
                      layout: Axis.vertical,
                      items: data.items,
                      currentItem: data.currentItem,
                      maxItem: data.maxItem,
                    ),
                    Positioned(
                      top: spacing100,
                      right: spacing100,
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

class _StepBarData extends InheritedWidget {
  const _StepBarData({
    required this.type,
    required this.items,
    required this.currentItem,
    required this.maxItem,
    required super.child,
  });

  final OptimusStepBarType type;
  final List<OptimusStepBarItem> items;
  final int currentItem;
  final int? maxItem;

  static _StepBarData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_StepBarData>();

  @override
  bool updateShouldNotify(_StepBarData oldWidget) => true;
}

const double _itemHeight = 66;
const double _verticalSpacing = 12;
