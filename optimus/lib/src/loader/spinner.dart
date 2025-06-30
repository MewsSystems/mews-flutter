import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/loader/painter.dart';

enum OptimusSpinnerSize { small, medium, large }

/// A spinner that indicates a loading state. It consists of three circles that
/// rotate in a loop. The spinner comes in three sizes: small, medium, and large.
/// The default size is medium.
class OptimusSpinner extends StatefulWidget {
  const OptimusSpinner({super.key, this.size = OptimusSpinnerSize.medium});

  /// The size of the spinner.
  final OptimusSpinnerSize size;

  @override
  State<OptimusSpinner> createState() => _OptimusSpinnerState();
}

class _OptimusSpinnerState extends State<OptimusSpinner>
    with SingleTickerProviderStateMixin, ThemeGetter {
  late final AnimationController _controller;

  late final Animation<double> _firstProgressAnimation;
  late final Animation<double> _firstBaseAnimation;
  late final Animation<double> _secondProgressAnimation;
  late final Animation<double> _secondBaseAnimation;
  late final Animation<double> _thirdProgressAnimation;
  late final Animation<double> _thirdBaseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _duration, vsync: this)
      ..repeat();

    _firstProgressAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(_firstStart, _firstEnd, curve: _animationCurve),
      ),
    );
    _firstBaseAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(_firstStart, _firstEnd, curve: _animationCurve),
      ),
    );

    _secondProgressAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(_secondStart, _secondEnd, curve: _animationCurve),
      ),
    );
    _secondBaseAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(_secondStart, _secondEnd, curve: _animationCurve),
      ),
    );

    _thirdProgressAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(_thirdStart, _thirdEnd, curve: _animationCurve),
      ),
    );
    _thirdBaseAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(_thirdStart, _thirdEnd, curve: _animationCurve),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    role: SemanticsRole.loadingSpinner,
    liveRegion: true,
    child: SizedBox.square(
      dimension: widget.size.getSize(tokens),
      child: AnimatedBuilder(
        animation: _controller,
        builder:
            (context, child) => Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size.square(widget.size.getSize(tokens)),
                  painter: CirclePainter(
                    indicatorColor:
                        tokens.backgroundInteractiveNeutralBoldDefault,
                    strokeWidth: widget.size.strokeWidth,
                    progress: _thirdProgressAnimation.value,
                    baseAngle: _thirdBaseAnimation.value,
                    strokeCap: StrokeCap.round,
                  ),
                  foregroundPainter: CirclePainter(
                    indicatorColor: tokens.backgroundAccentSecondary,
                    strokeWidth: widget.size.strokeWidth,
                    progress: _secondProgressAnimation.value,
                    baseAngle: _secondBaseAnimation.value,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                CustomPaint(
                  size: Size.square(widget.size.getSize(tokens)),
                  painter: CirclePainter(
                    indicatorColor: tokens.backgroundAccentPrimary,
                    strokeWidth: widget.size.strokeWidth,
                    progress: _firstProgressAnimation.value,
                    baseAngle: _firstBaseAnimation.value,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ],
            ),
      ),
    ),
  );
}

extension on OptimusSpinnerSize {
  double getSize(OptimusTokens tokens) => switch (this) {
    OptimusSpinnerSize.small => tokens.sizing300,
    OptimusSpinnerSize.medium => tokens.sizing500,
    OptimusSpinnerSize.large => tokens.sizing700,
  };

  double get strokeWidth => switch (this) {
    OptimusSpinnerSize.small => 2,
    OptimusSpinnerSize.medium || OptimusSpinnerSize.large => 4,
  };
}

const _duration = Duration(seconds: 2);
const _firstStart = 0.0;
const _secondStart = 0.05;
const _thirdStart = 0.1;
const _firstEnd = _firstStart + _rotationDuration;
const _secondEnd = _secondStart + _rotationDuration;
const _thirdEnd = _thirdStart + _rotationDuration;
const _rotationDuration = 0.75;
const _animationCurve = Cubic(0.48, 0, 0.4, 1);
