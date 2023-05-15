import 'dart:math';

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

abstract class AnchoredOverlayController {
  const AnchoredOverlayController();

  double get maxHeight;
  double get width;
  double get top;
  double get bottom;
}

class AnchoredOverlayData extends InheritedWidget {
  const AnchoredOverlayData({
    super.key,
    required super.child,
    required this.controller,
  });

  final AnchoredOverlayController controller;

  @override
  bool updateShouldNotify(AnchoredOverlayData oldWidget) => true;
}

class AnchoredOverlay extends StatefulWidget {
  const AnchoredOverlay({
    super.key,
    required this.anchorKey,
    required this.child,
    required this.width,
    this.rootOverlay = false,
  });

  final GlobalKey anchorKey;
  final double? width;
  final Widget child;
  final bool rootOverlay;

  static AnchoredOverlayController? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AnchoredOverlayData>()
      ?.controller;

  @override
  State<AnchoredOverlay> createState() => AnchoredOverlayState();
}

class AnchoredOverlayState extends State<AnchoredOverlay>
    implements AnchoredOverlayController {
  late Rect _savedRect = _calculateRect();
  late Size? _overlaySize = _getOverlaySize();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_updateRect);
  }

  @override
  void didUpdateWidget(AnchoredOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(_updateRect);
  }

  double get _overlayHeight => _overlaySize?.height ?? 0;

  double get _overlayWidth => _overlaySize?.width ?? 0;

  double get _offsetBottom => _overlayHeight - _savedRect.top + _widgetPadding;

  double get _offsetTop => _savedRect.top + _savedRect.height + _widgetPadding;

  double get _paddingBottom =>
      MediaQuery.of(context).viewInsets.bottom + _screenPadding;

  double get _paddingTop => MediaQuery.of(context).padding.top + _screenPadding;

  double get _rightSpace => _overlayWidth - _savedRect.left;

  double get _leftSpace => _savedRect.right;

  double get _width => widget.width ?? _savedRect.width;

  bool get _isOnTop => top > bottom;

  @override
  double get maxHeight => max(top, bottom);

  @override
  double get width => widget.width ?? _savedRect.width;

  @override
  double get bottom => _overlayHeight - _paddingBottom - _savedRect.bottom;

  @override
  double get top => _savedRect.top - _paddingTop;

  void _updateRect(dynamic _) {
    if (!mounted) return;
    final newRect = _calculateRect();
    if (newRect != _savedRect) {
      final newSize = _getOverlaySize();
      setState(() {
        _savedRect = newRect;
        _overlaySize = newSize;
      });
    }
  }

  Rect _calculateRect() {
    final renderObject = widget.anchorKey.currentContext?.findRenderObject();
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
  Widget build(BuildContext context) {
    final widthWithPadding = _width + _widgetPadding;

    // If we have enough space to the right, dropdown's left side will be
    // aligned with anchor's left side. If there's not enough space to the
    // right, but enough space to the left, dropdown's right side will be
    // aligned with anchor's right side. If both conditions fail, left and
    // right will both be null, so dropdown will be aligned according to
    // Stack's alignment property.
    double? left, right;
    if (_rightSpace >= widthWithPadding) {
      left = _savedRect.left;
    } else if (_leftSpace >= widthWithPadding) {
      right = _overlayWidth - _savedRect.right;
    }

    return AnchoredOverlayData(
      controller: this,
      child: Builder(
        // Some problem with AnimatedPosition here:
        // 'package:flutter/src/animation/tween.dart':
        // Failed assertion: line 258 pos 12: 'begin != null': is not true.
        // Switching to Positioned.
        builder: (context) => Positioned(
          width: _width,
          left: left,
          right: right,
          top: _isOnTop ? null : _offsetTop,
          bottom: _isOnTop ? _offsetBottom : null,
          child: widget.child,
        ),
      ),
    );
  }
}

const double _screenPadding = spacing200;
const double _widgetPadding = spacing100;
