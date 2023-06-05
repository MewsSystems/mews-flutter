import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CirclePainter extends CustomPainter {
  CirclePainter({
    required this.trackColor,
    required this.indicatorColor,
    required this.progress,
    this.baseAngle = 0,
  }) : assert(
          progress >= 0 && progress <= 100,
          'progress should be in [0, 100] range',
        );

  final Color trackColor;
  final Color indicatorColor;
  final double progress;
  final double baseAngle;

  static const _twoPi = 2 * pi;
  static const _topStartAngle = 3 * pi / 2;

  double get _startAngle => _twoPi * baseAngle + _topStartAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final strokeWidth = size.width / 10;
    final center = Offset(radius, radius);

    final trackCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = trackColor
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, trackCircle);

    final indicatorArc = Paint()
      ..strokeWidth = strokeWidth
      ..color = indicatorColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _startAngle,
      _twoPi * (progress / 100),
      false,
      indicatorArc,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      trackColor != oldDelegate.trackColor ||
      indicatorColor != oldDelegate.indicatorColor ||
      progress != oldDelegate.progress ||
      baseAngle != oldDelegate.baseAngle;
}
