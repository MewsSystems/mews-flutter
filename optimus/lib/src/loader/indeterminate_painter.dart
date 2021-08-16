import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class IndeterminatePainter extends CustomPainter {
  // IndeterminatePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width / 2;
    final height = size.height / 2;

    final double strokeWidth = 10;

    final center = Offset(width, height);

    /// Background circle
    final circle = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.grey.withAlpha(86)
      ..style = PaintingStyle.stroke;

    final radius = width;
    canvas.drawCircle(center, radius, circle);

    /// Background timer progress circle
    final timerCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.amber
      ..style = PaintingStyle.stroke;

    final timerCircleRadius = width;
    canvas.drawCircle(center, timerCircleRadius, timerCircle);

    // /// Progress timer circle
    // final timerAnimationArc = Paint()
    //   ..strokeWidth = 10
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke
    //   ..strokeCap = StrokeCap.square;
    //
    // final angle = 2 * pi * (progress / 100);
    // canvas.drawArc(
    //   Rect.fromCircle(center: center, radius: radius),
    //   pi / 2,
    //   angle,
    //   false,
    //   timerAnimationArc,
    // );

    // /// Progress dot
    // final double dx = width - radius * sin(angle);
    // final double dy = height + radius * cos(angle);
    // const dotRadius = 8.0;
    //
    // final dotPaint = Paint()
    //   ..color = Colors.deepOrange
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = dotRadius;
    //
    // canvas.drawCircle(Offset(dx, dy), dotRadius, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
