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
    this.rootOverlay = false,
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
  final bool rootOverlay;

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
  late OptimusTooltipPosition _position = _getPreferredPosition;

  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterInitialLayoutCallback);
  }

  @override
  void didUpdateWidget(TooltipOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(_updateRect);
  }

  double get _overlayWidth => _overlaySize?.width ?? 0;

  double get _overlayHeight => _overlaySize?.height ?? 0;

  bool get _isOnTop => _spaceTop > _spaceBottom;

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

  OptimusTooltipPosition get _getPreferredPosition =>
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

  bool _isOverflowing(OptimusTooltipPosition position) {
    switch (position) {
      case OptimusTooltipPosition.top:
        return _tooltipRect.top < _screenPadding;
      case OptimusTooltipPosition.bottom:
        return _tooltipRect.bottom > _overlayHeight - _screenPadding;
      case OptimusTooltipPosition.left:
        return _tooltipRect.left < _screenPadding;
      case OptimusTooltipPosition.right:
        return _tooltipRect.right > _overlayWidth - _screenPadding;
    }
  }

  double get _leftOffset {
    switch (alignment) {
      case TooltipAlignment.leftTop:
      case TooltipAlignment.leftCenter:
      case TooltipAlignment.leftBottom:
        return _savedRect.left - _tooltipRect.width - _sideAlignOffset;
      case TooltipAlignment.rightTop:
      case TooltipAlignment.rightCenter:
      case TooltipAlignment.rightBottom:
        return _savedRect.right + _widgetPadding;
      case TooltipAlignment.topLeft:
      case TooltipAlignment.bottomLeft:
        return _savedRect.right - _tooltipRect.width + _sideAlignOffset;
      case TooltipAlignment.topCenter:
      case TooltipAlignment.bottomCenter:
        return _savedRect.left +
            (_savedRect.width / 2 - _tooltipRect.width / 2);
      case TooltipAlignment.topRight:
      case TooltipAlignment.bottomRight:
        return _savedRect.left - _sideAlignOffset;
    }
  }

  double? get _topOffset {
    switch (alignment) {
      case TooltipAlignment.rightTop:
      case TooltipAlignment.leftTop:
        return null;
      case TooltipAlignment.leftBottom:
      case TooltipAlignment.rightBottom:
        return _savedRect.top + _savedRect.height / 2 - _tooltipAlignOffset;
      case TooltipAlignment.rightCenter:
      case TooltipAlignment.leftCenter:
        return _savedRect.top +
            (_savedRect.height / 2 - _tooltipRect.height / 2);
      case TooltipAlignment.topCenter:
      case TooltipAlignment.topLeft:
      case TooltipAlignment.topRight:
        return _savedRect.top - _tooltipRect.height - _widgetPadding;
      case TooltipAlignment.bottomLeft:
      case TooltipAlignment.bottomCenter:
      case TooltipAlignment.bottomRight:
        return _savedRect.bottom + _widgetPadding;
    }
  }

  double? get _bottomOffset {
    switch (alignment) {
      case TooltipAlignment.rightTop:
      case TooltipAlignment.leftTop:
        return _overlayHeight -
            _savedRect.top -
            _savedRect.height / 2 -
            _tooltipAlignOffset;
      case TooltipAlignment.leftBottom:
      case TooltipAlignment.rightBottom:
      case TooltipAlignment.rightCenter:
      case TooltipAlignment.leftCenter:
      case TooltipAlignment.topCenter:
      case TooltipAlignment.topLeft:
      case TooltipAlignment.topRight:
      case TooltipAlignment.bottomLeft:
      case TooltipAlignment.bottomCenter:
      case TooltipAlignment.bottomRight:
        return null;
    }
  }

  @override
  TooltipAlignment get alignment {
    switch (_position) {
      case OptimusTooltipPosition.top:
        return _calculateHorizontalAlignment(
          TooltipAlignment.topLeft,
          TooltipAlignment.topCenter,
          TooltipAlignment.topRight,
        );
      case OptimusTooltipPosition.bottom:
        return _calculateHorizontalAlignment(
          TooltipAlignment.bottomLeft,
          TooltipAlignment.bottomCenter,
          TooltipAlignment.bottomRight,
        );
      case OptimusTooltipPosition.left:
        return _calculateVerticalAlignment(
          TooltipAlignment.leftTop,
          TooltipAlignment.leftCenter,
          TooltipAlignment.leftBottom,
        );
      case OptimusTooltipPosition.right:
        return _calculateVerticalAlignment(
          TooltipAlignment.rightTop,
          TooltipAlignment.rightCenter,
          TooltipAlignment.rightBottom,
        );
    }
  }

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

  void _afterInitialLayoutCallback(dynamic _) {
    _updateRect(_);
    WidgetsBinding.instance.addPostFrameCallback(_afterFirstLayoutCallback);
  }

  void _afterFirstLayoutCallback(dynamic _) {
    if (!mounted) return;
    setState(() {
      _position = _calculatePosition();
      _opacity = 1.0;
    });
  }

  void _updateRect(dynamic _) {
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

  RenderBox? _getOverlay() =>
      Overlay.of(context, rootOverlay: widget.rootOverlay)
          .context
          .findRenderObject() as RenderBox?;

  Size? _getOverlaySize() => _getOverlay()?.size;

  @override
  Widget build(BuildContext context) => TooltipOverlayData(
        controller: this,
        child: Builder(
          builder: (context) => Positioned(
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

const double _screenPadding = spacing200;
const double _widgetPadding = spacing100;
const double _sideAlignOffset = spacing100;
const double _tooltipAlignOffset = 18.0;
const Duration _animationDuration = Duration(milliseconds: 100);
