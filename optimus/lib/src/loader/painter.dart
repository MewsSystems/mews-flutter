import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/loader/loader.dart';

class CirclePainter extends CustomPainter {
  CirclePainter({
    required this.trackColor,
    required this.indicatorColor,
    required this.progress,
    required this.variant,
  });

  final Color trackColor;
  final Color indicatorColor;
  double? progress;
  final OptimusCircleLoaderVariant variant;

  double get _startAngle {
    switch (variant) {
      case OptimusCircleLoaderVariant.determinate:
        return 3 * pi / 2;
      case OptimusCircleLoaderVariant.indeterminate:
        return 3 * pi / 4;
    }
  }

  double get _sweepAngle {
    switch (variant) {
      case OptimusCircleLoaderVariant.determinate:
        return 2 * pi * (progress! / 100);
      case OptimusCircleLoaderVariant.indeterminate:
        return 2 * pi * (25 / 100);
    }
  }

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
      _startAngle,
      _sweepAngle,
      false,
      indicatorArc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
