import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class TooltipArrow extends StatelessWidget {
  const TooltipArrow({
    Key? key,
    required this.position,
    required this.color,
  }) : super(key: key);

  final OptimusTooltipPosition position;
  final Color color;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: position.width,
        height: position.height,
        child: CustomPaint(
          painter: _TrianglePainter(tooltipPosition: position, color: color),
        ),
      );
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.tooltipPosition,
    required this.color,
  });

  final OptimusTooltipPosition tooltipPosition;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    switch (tooltipPosition) {
      case OptimusTooltipPosition.right:
        path.moveTo(0, size.height / 2);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        break;
      case OptimusTooltipPosition.bottom:
        path.moveTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        break;
      case OptimusTooltipPosition.left:
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
      case OptimusTooltipPosition.top:
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        break;
    }
    path.close();
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      (oldDelegate as _TrianglePainter).tooltipPosition != tooltipPosition;
}

extension on OptimusTooltipPosition {
  double get width {
    switch (this) {
      case OptimusTooltipPosition.left:
      case OptimusTooltipPosition.right:
        return 5;
      case OptimusTooltipPosition.top:
      case OptimusTooltipPosition.bottom:
        return 10;
    }
  }

  double get height {
    switch (this) {
      case OptimusTooltipPosition.left:
      case OptimusTooltipPosition.right:
        return 10;
      case OptimusTooltipPosition.top:
      case OptimusTooltipPosition.bottom:
        return 5;
    }
  }
}
