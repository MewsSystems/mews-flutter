import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class CustomOutlinedBorder extends OutlinedBorder {
  const CustomOutlinedBorder({
    this.borderRadius = BorderRadius.zero,
    this.borderSide = BorderSide.none,
    this.hasTop = true,
    this.hasRight = true,
    this.hasBottom = true,
    this.hasLeft = true,
  });

  final BorderRadiusGeometry borderRadius;
  final BorderSide borderSide;
  final bool hasTop;
  final bool hasRight;
  final bool hasBottom;
  final bool hasLeft;

  @override
  OutlinedBorder copyWith({
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
  }) => CustomOutlinedBorder(
    borderRadius: borderRadius ?? this.borderRadius,
    borderSide: side ?? borderSide,
    hasTop: hasTop,
    hasRight: hasRight,
    hasBottom: hasBottom,
    hasLeft: hasLeft,
  );

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final RRect borderRect = borderRadius.resolve(textDirection).toRRect(rect);
    final RRect adjustedRect = borderRect.deflate(borderSide.width / 2);

    return Path()..addRRect(adjustedRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Paint paint = borderSide.toPaint();
    final RRect borderRect = borderRadius
        .resolve(textDirection)
        .toRRect(rect)
        .deflate(borderSide.width / 2);

    // have to add an offset because of the deflation if the connecting side is not present, otherwise there will be a gap
    final double pixelOffset = borderSide.width / 2;

    if (hasTop) {
      final double leftOffset = hasLeft ? 0 : pixelOffset;
      final double rightOffset = hasRight ? 0 : pixelOffset;
      canvas.drawLine(
        Offset(
          borderRect.left + borderRect.tlRadiusX - leftOffset,
          borderRect.top,
        ),
        Offset(
          borderRect.right - borderRect.trRadiusX + rightOffset,
          borderRect.top,
        ),
        paint,
      );
    }
    if (hasRight) {
      final double topOffset = hasTop ? 0 : pixelOffset;
      final double bottomOffset = hasBottom ? 0 : pixelOffset;
      canvas.drawLine(
        Offset(
          borderRect.right,
          borderRect.top + borderRect.trRadiusY - topOffset,
        ),
        Offset(
          borderRect.right,
          borderRect.bottom - borderRect.brRadiusY + bottomOffset,
        ),
        paint,
      );
    }
    if (hasBottom) {
      final double leftOffset = hasLeft ? 0 : pixelOffset;
      final double rightOffset = hasRight ? 0 : pixelOffset;
      canvas.drawLine(
        Offset(
          borderRect.right - borderRect.brRadiusX + rightOffset,
          borderRect.bottom,
        ),
        Offset(
          borderRect.left + borderRect.blRadiusX - leftOffset,
          borderRect.bottom,
        ),
        paint,
      );
    }
    if (hasLeft) {
      final double topOffset = hasTop ? 0 : pixelOffset;
      final double bottomOffset = hasBottom ? 0 : pixelOffset;
      canvas.drawLine(
        Offset(
          borderRect.left,
          borderRect.bottom - borderRect.blRadiusY + bottomOffset,
        ),
        Offset(
          borderRect.left,
          borderRect.top + borderRect.tlRadiusY + topOffset,
        ),
        paint,
      );
    }

    // Draw the rounded corners
    if (hasTop && hasLeft) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(
            borderRect.left + borderRect.tlRadiusX,
            borderRect.top + borderRect.tlRadiusY,
          ),
          radius: borderRect.tlRadiusX,
        ),
        -math.pi,
        math.pi / 2,
        false,
        paint,
      );
    }
    if (hasTop && hasRight) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(
            borderRect.right - borderRect.trRadiusX,
            borderRect.top + borderRect.trRadiusY,
          ),
          radius: borderRect.trRadiusX,
        ),
        -math.pi / 2,
        math.pi / 2,
        false,
        paint,
      );
    }
    if (hasBottom && hasRight) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(
            borderRect.right - borderRect.brRadiusX,
            borderRect.bottom - borderRect.brRadiusY,
          ),
          radius: borderRect.brRadiusX,
        ),
        0,
        math.pi / 2,
        false,
        paint,
      );
    }
    if (hasBottom && hasLeft) {
      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(
            borderRect.left + borderRect.blRadiusX,
            borderRect.bottom - borderRect.blRadiusY,
          ),
          radius: borderRect.blRadiusX,
        ),
        math.pi / 2,
        math.pi / 2,
        false,
        paint,
      );
    }
  }

  @override
  ShapeBorder scale(double t) => CustomOutlinedBorder(
    borderRadius: borderRadius * t,
    borderSide: borderSide.scale(t),
    hasTop: hasTop,
    hasRight: hasRight,
    hasBottom: hasBottom,
    hasLeft: hasLeft,
  );

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.all(math.max(borderSide.width, 0));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is CustomOutlinedBorder &&
        other.borderRadius == borderRadius &&
        other.borderSide == borderSide &&
        other.hasTop == hasTop &&
        other.hasRight == hasRight &&
        other.hasBottom == hasBottom &&
        other.hasLeft == hasLeft;
  }

  @override
  int get hashCode => Object.hash(
    borderRadius,
    borderSide,
    hasTop,
    hasRight,
    hasBottom,
    hasLeft,
  );

  @override
  String toString() =>
      'CustomOutlinedBorder($borderRadius, $borderSide, top: $hasTop, right: $hasRight, bottom: $hasBottom, left: $hasLeft)';
}
