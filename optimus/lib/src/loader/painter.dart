import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class CirclePainter extends CustomPainter {
  CirclePainter({
    required this.trackColor,
    required this.indicatorColor,
    required this.progress,
  });

  final Color trackColor;
  final Color indicatorColor;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final strokeWidth = size.width / 10;
    final center = Offset(radius, radius);

    /// Track circle
    final trackCircle = Paint()
      ..strokeWidth = strokeWidth
      ..color = trackColor
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, trackCircle);

    /// Indicator circle
    final indicatorArc = Paint()
      ..strokeWidth = strokeWidth
      ..color = indicatorColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3 * pi / 2,
      2 * pi * (progress / 100),
      false,
      indicatorArc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
