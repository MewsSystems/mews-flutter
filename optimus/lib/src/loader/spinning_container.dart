import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpinningContainer extends StatefulWidget {
  const SpinningContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<SpinningContainer> createState() => _SpinningContainerState();
}

class _SpinningContainerState extends State<SpinningContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _SpinningContainer(widget.child, controller: _controller);
}

class _SpinningContainer extends AnimatedWidget {
  const _SpinningContainer(
    this.child, {
    Key? key,
    required AnimationController controller,
  }) : super(key: key, listenable: controller);

  final Widget child;

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) =>
      Transform.rotate(angle: _progress.value * 2.0 * pi, child: child);
}
