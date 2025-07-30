import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/tooltip/tooltip_alignment.dart';

abstract class TooltipOverlayController {
  const TooltipOverlayController();

  TooltipAlignment get alignment;
}

class TooltipOverlayData extends InheritedWidget {
  const TooltipOverlayData({
    super.key,
    required super.child,
    required this.controller,
  });

  final TooltipOverlayController controller;

  @override
  bool updateShouldNotify(TooltipOverlayData oldWidget) => true;
}

class TooltipOverlay extends StatefulWidget {
  const TooltipOverlay({
    super.key,
    required this.anchorKey,
    required this.tooltip,
    this.useRootOverlay = false,
    required this.tooltipKey,
    this.position,
  });

  /// Key of the widget that should be wrapped with the tooltip.
  final GlobalKey anchorKey;

  /// Key of the tooltip widget.
  final GlobalKey tooltipKey;

  /// Tooltip widget.
  final OptimusTooltip tooltip;

  /// Whether the tooltip should use the root overlay.
  final bool useRootOverlay;

  /// Position of the tooltip relative to the child widget. If not specified,
  /// the tooltip will be positioned automatically. Depending on the space
  /// available will be set to [OptimusTooltipPosition.top] or
  /// [OptimusTooltipPosition.bottom].
  final OptimusTooltipPosition? position;

  static TooltipOverlayController? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<TooltipOverlayData>()
      ?.controller;

  @override
  State<TooltipOverlay> createState() => TooltipOverlayState();
}

class TooltipOverlayState extends State<TooltipOverlay>
    implements TooltipOverlayController {
  late Rect _savedRect = _calculateRect(widget.anchorKey);
  late Rect _tooltipRect = _calculateRect(widget.tooltipKey);
  late Size? _overlaySize = _getOverlaySize();
  late OptimusTooltipPosition _position = _preferredPosition;

  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _afterInitialLayoutCallback(),
    );
  }

  @override
  void didUpdateWidget(TooltipOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateRect());
  }

  double get _overlayWidth => _overlaySize?.width ?? 0;

  double get _overlayHeight => _overlaySize?.height ?? 0;

  bool get _isOnTop => _spaceTop > _spaceBottom;

  double get _widgetPadding => context.tokens.spacing100;

  double get _screenPadding => context.tokens.spacing200;

  double get _sideAlignOffset => context.tokens.spacing100;

  double get _spaceLeft => _savedRect.left - _widgetPadding;

  double get _spaceRight => _overlayWidth - _widgetPadding - _savedRect.right;

  double get _spaceTop => _savedRect.top - _screenPadding;

  double get _spaceBottom =>
      _overlayHeight - _screenPadding - _savedRect.bottom;

  double get _horizontalCenterLeft =>
      _savedRect.left + _savedRect.width / 2 - _tooltipRect.width / 2;

  double get _horizontalCenterRight =>
      _savedRect.left + _savedRect.width / 2 + _tooltipRect.width / 2;

  double get _verticalCenterTop =>
      _savedRect.top - _savedRect.height / 2 - _tooltipRect.height / 2;

  double get _verticalCenterBottom =>
      _savedRect.top - _savedRect.height / 2 + _tooltipRect.height / 2;

  OptimusTooltipPosition get _preferredPosition =>
      widget.position ?? _fallbackPosition;

  OptimusTooltipPosition get _fallbackPosition =>
      _isOnTop ? OptimusTooltipPosition.top : OptimusTooltipPosition.bottom;

  OptimusTooltipPosition _calculatePosition() {
    final position = widget.position;

    return position != null
        ? _isOverflowing(position)
              ? _fallbackPosition
              : position
        : _fallbackPosition;
  }

  bool _isOverflowing(OptimusTooltipPosition position) => switch (position) {
    OptimusTooltipPosition.top => _tooltipRect.top < _screenPadding,
    OptimusTooltipPosition.bottom =>
      _tooltipRect.bottom > _overlayHeight - _screenPadding,
    OptimusTooltipPosition.left => _tooltipRect.left < _screenPadding,
    OptimusTooltipPosition.right =>
      _tooltipRect.right > _overlayWidth - _screenPadding,
  };

  double get _leftOffset => switch (alignment) {
    TooltipAlignment.leftTop ||
    TooltipAlignment.leftCenter ||
    TooltipAlignment.leftBottom =>
      _savedRect.left - _tooltipRect.width - _sideAlignOffset,
    TooltipAlignment.rightTop ||
    TooltipAlignment.rightCenter ||
    TooltipAlignment.rightBottom => _savedRect.right + _widgetPadding,
    TooltipAlignment.topLeft || TooltipAlignment.bottomLeft =>
      _savedRect.right - _tooltipRect.width + _sideAlignOffset,
    TooltipAlignment.topCenter || TooltipAlignment.bottomCenter =>
      _savedRect.left + (_savedRect.width / 2 - _tooltipRect.width / 2),
    TooltipAlignment.topRight ||
    TooltipAlignment.bottomRight => _savedRect.left - _sideAlignOffset,
  };

  double? get _topOffset => switch (alignment) {
    TooltipAlignment.rightTop || TooltipAlignment.leftTop => null,
    TooltipAlignment.leftBottom || TooltipAlignment.rightBottom =>
      _savedRect.top + _savedRect.height / 2 - _tooltipAlignOffset,
    TooltipAlignment.rightCenter || TooltipAlignment.leftCenter =>
      _savedRect.top + (_savedRect.height / 2 - _tooltipRect.height / 2),
    TooltipAlignment.topCenter ||
    TooltipAlignment.topLeft ||
    TooltipAlignment.topRight =>
      _savedRect.top - _tooltipRect.height - _widgetPadding,
    TooltipAlignment.bottomLeft ||
    TooltipAlignment.bottomCenter ||
    TooltipAlignment.bottomRight => _savedRect.bottom + _widgetPadding,
  };

  double? get _bottomOffset => switch (alignment) {
    TooltipAlignment.rightTop || TooltipAlignment.leftTop =>
      _overlayHeight -
          _savedRect.top -
          _savedRect.height / 2 -
          _tooltipAlignOffset,
    TooltipAlignment.leftBottom ||
    TooltipAlignment.rightBottom ||
    TooltipAlignment.rightCenter ||
    TooltipAlignment.leftCenter ||
    TooltipAlignment.topCenter ||
    TooltipAlignment.topLeft ||
    TooltipAlignment.topRight ||
    TooltipAlignment.bottomLeft ||
    TooltipAlignment.bottomCenter ||
    TooltipAlignment.bottomRight => null,
  };

  @override
  TooltipAlignment get alignment => switch (_position) {
    OptimusTooltipPosition.top => _calculateHorizontalAlignment(
      TooltipAlignment.topLeft,
      TooltipAlignment.topCenter,
      TooltipAlignment.topRight,
    ),
    OptimusTooltipPosition.bottom => _calculateHorizontalAlignment(
      TooltipAlignment.bottomLeft,
      TooltipAlignment.bottomCenter,
      TooltipAlignment.bottomRight,
    ),
    OptimusTooltipPosition.left => _calculateVerticalAlignment(
      TooltipAlignment.leftTop,
      TooltipAlignment.leftCenter,
      TooltipAlignment.leftBottom,
    ),
    OptimusTooltipPosition.right => _calculateVerticalAlignment(
      TooltipAlignment.rightTop,
      TooltipAlignment.rightCenter,
      TooltipAlignment.rightBottom,
    ),
  };

  TooltipAlignment _calculateHorizontalAlignment(
    TooltipAlignment start,
    TooltipAlignment center,
    TooltipAlignment end,
  ) =>
      _horizontalCenterLeft < _screenPadding ||
          _horizontalCenterRight > _overlayWidth - _screenPadding
      ? _spaceLeft > _spaceRight
            ? start
            : end
      : center;

  TooltipAlignment _calculateVerticalAlignment(
    TooltipAlignment start,
    TooltipAlignment center,
    TooltipAlignment end,
  ) =>
      _verticalCenterTop < _screenPadding ||
          _verticalCenterBottom > _overlayHeight - _screenPadding
      ? _spaceTop > _spaceBottom
            ? start
            : end
      : center;

  void _afterInitialLayoutCallback() {
    _updateRect();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _afterFirstLayoutCallback(),
    );
  }

  void _afterFirstLayoutCallback() {
    if (!mounted) return;
    setState(() {
      _position = _calculatePosition();
      _opacity = 1.0;
    });
  }

  void _updateRect() {
    if (!mounted) return;
    final newRect = _calculateRect(widget.anchorKey);
    final newTooltipRect = _calculateRect(widget.tooltipKey);
    if (newRect != _savedRect || newTooltipRect != _tooltipRect) {
      final newSize = _getOverlaySize();
      setState(() {
        _savedRect = newRect;
        _tooltipRect = newTooltipRect;
        _overlaySize = newSize;
      });
    }
  }

  Rect _calculateRect(GlobalKey key) {
    final renderObject = key.currentContext?.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return Rect.zero;
    final size = renderObject.size;

    return renderObject.localToGlobal(Offset.zero, ancestor: _getOverlay()) &
        size;
  }

  RenderBox? _getOverlay() {
    final renderObject = Overlay.of(
      context,
      rootOverlay: widget.useRootOverlay,
    ).context.findRenderObject();
    if (renderObject is RenderBox) return renderObject;
  }

  Size? _getOverlaySize() => _getOverlay()?.size;

  @override
  Widget build(BuildContext context) => TooltipOverlayData(
    controller: this,
    child: Builder(
      builder: (_) => Positioned(
        left: _leftOffset,
        top: _topOffset,
        bottom: _bottomOffset,
        child: AnimatedOpacity(
          opacity: _opacity,
          curve: Curves.easeIn,
          duration: _animationDuration,
          child: widget.tooltip,
        ),
      ),
    ),
  );
}

const double _tooltipAlignOffset = 20.0; // TODO(witwash): check with design
const Duration _animationDuration = Duration(milliseconds: 100);
