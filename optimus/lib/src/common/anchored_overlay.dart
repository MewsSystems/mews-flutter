import 'dart:math';

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

abstract class AnchoredOverlayController {
  double get maxHeight;
  double get width;
  double get topSpace;
  double get bottomSpace;
}

class AnchoredOverlayData extends InheritedWidget {
  const AnchoredOverlayData({
    Key? key,
    required Widget child,
    required this.controller,
  }) : super(key: key, child: child);

  final AnchoredOverlayController controller;

  @override
  bool updateShouldNotify(AnchoredOverlayData oldWidget) => false;
}

class AnchoredOverlay extends StatefulWidget {
  const AnchoredOverlay({
    Key? key,
    required this.anchorKey,
    required this.child,
    required this.width,
  }) : super(key: key);

  final GlobalKey anchorKey;
  final double? width;
  final Widget child;

  static AnchoredOverlayController? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AnchoredOverlayData>()
      ?.controller;

  @override
  State<AnchoredOverlay> createState() => AnchoredOverlayState();
}

class AnchoredOverlayState extends State<AnchoredOverlay>
    implements AnchoredOverlayController {
  late Rect _savedRect = _calculateRect();

  void _updateRect(dynamic _) {
    if (!mounted) return;
    final newRect = _calculateRect();
    if (newRect != _savedRect) {
      setState(() {
        _savedRect = newRect;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_updateRect);
  }

  double get _screenHeight => MediaQuery.of(context).size.height;

  double get _screenWidth => MediaQuery.of(context).size.width;

  double get _offsetBottom => _screenHeight - _savedRect.top + _widgetPadding;

  double get _offsetTop => _savedRect.top + _savedRect.height + _widgetPadding;

  double get _paddingBottom =>
      MediaQuery.of(context).viewInsets.bottom + _screenPadding;

  double get _paddingTop => MediaQuery.of(context).padding.top + _screenPadding;

  double get _rightSpace => _screenWidth - _savedRect.left;

  double get _leftSpace => _savedRect.right;

  double get _width => widget.width ?? _savedRect.width;

  Rect _calculateRect() {
    final renderObject = widget.anchorKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return Rect.zero;

    final size = renderObject.size;

    final overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox?;

    return renderObject.localToGlobal(Offset.zero, ancestor: overlay) & size;
  }

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
      right = _screenWidth - _savedRect.right;
    }

    return AnchoredOverlayData(
      controller: this,
      child: Builder(
        builder: (context) => Positioned(
          width: _width,
          left: left,
          right: right,
          top: isOnTop ? null : _offsetTop,
          bottom: isOnTop ? _offsetBottom : null,
          child: widget.child,
        ),
      ),
    );
  }

  bool get isOnTop => topSpace > bottomSpace;

  @override
  double get maxHeight => max(topSpace, bottomSpace);

  @override
  double get width => widget.width ?? _savedRect.width;

  @override
  double get bottomSpace => _screenHeight - _paddingBottom - _savedRect.bottom;

  @override
  double get topSpace => _savedRect.top - _paddingTop;
}

const double _screenPadding = spacing200;
const double _widgetPadding = spacing100;
