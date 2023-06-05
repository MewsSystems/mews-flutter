import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/loader/painter.dart';

class SpinningLoader extends StatefulWidget {
  const SpinningLoader({
    Key? key,
    required this.progress,
    required this.trackColor,
    required this.indicatorColor,
  }) : super(key: key);

  final double progress;
  final Color trackColor;
  final Color indicatorColor;

  @override
  State<SpinningLoader> createState() => _SpinningLoaderState();
}

class _SpinningLoaderState extends State<SpinningLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static final Animatable<double> _rotationTween =
      CurveTween(curve: const SawTooth(_rotationCount));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _spinningDuration),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => CustomPaint(
          foregroundPainter: CirclePainter(
            trackColor: widget.trackColor,
            indicatorColor: widget.indicatorColor,
            progress: widget.progress,
            baseAngle: _rotationTween.evaluate(_controller),
          ),
        ),
      );
}

const int _spinningDuration = 15000;
const int _rotationCount = 15;
