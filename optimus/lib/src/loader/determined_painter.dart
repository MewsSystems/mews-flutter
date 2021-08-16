import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class DeterminedPainter extends CustomPainter {
  DeterminedPainter({
    required this.progress,
  });

  double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width / 2;
    final height = size.height / 2;
    final radius = width;

    final double strokeWidth = size.width / 10;
    final center = Offset(width, height);

    /// Background timer progress circle
    final timerCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.amber
      ..style = PaintingStyle.stroke;

    final timerCircleRadius = width;
    canvas.drawCircle(center, timerCircleRadius, timerCircle);

    /// Progress timer circle
    final timerAnimationArc = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final angle = 2 * pi * (progress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3 * pi / 2,
      angle,
      false,
      timerAnimationArc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
