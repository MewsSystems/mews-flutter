import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';

/// A widget that provides a shimmer effect for loading states.
/// [OptimusSkeleton] will ensure that the shimmer effect is applied to its
/// descendants and is synchronized with the shimmer controller.
class OptimusSkeleton extends StatefulWidget {
  const OptimusSkeleton({super.key, this.child});

  static OptimusSkeletonState? of(BuildContext context) =>
      context.findAncestorStateOfType<OptimusSkeletonState>();

  final Widget? child;

  @override
  OptimusSkeletonState createState() => OptimusSkeletonState();
}

class OptimusSkeletonState extends State<OptimusSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 2.5, period: const Duration(milliseconds: 1600));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  // ignore: prefer-widget-private-members, required for the sync
  LinearGradient get gradient => LinearGradient(
    colors: context.linearGradient.colors,
    stops: context.linearGradient.stops,
    begin: context.linearGradient.begin,
    end: context.linearGradient.end,
    transform: _SlidingGradientTransform(
      slidePercent: _shimmerController.value,
    ),
  );

  // ignore: prefer-widget-private-members, required for the sync
  bool get isSized {
    final findRenderObject = context.findRenderObject();

    return findRenderObject is RenderBox?
        ? (findRenderObject?.hasSize ?? false)
        : false;
  }

  // ignore: prefer-widget-private-members, required for the sync
  Size get size {
    final renderObject = context.findRenderObject();

    return renderObject is RenderBox ? renderObject.size : Size.zero;
  }

  // ignore: prefer-widget-private-members, required for the sync
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject();

    return shimmerBox is RenderBox
        ? descendant.localToGlobal(offset, ancestor: shimmerBox)
        : Offset.zero;
  }

  // ignore: prefer-widget-private-members, required for the sync
  Listenable get shimmerController => _shimmerController;

  @override
  Widget build(BuildContext context) => widget.child ?? const SizedBox();
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
}

abstract class OptimusBone extends StatefulWidget {
  const OptimusBone({super.key, required this.isLoading, required this.child});

  OptimusBone.square({
    super.key,
    required this.isLoading,
    required double width,
    required double height,
  }) : child = _SquareBone.square(width: width, height: height);

  OptimusBone.textLine({
    super.key,
    required this.isLoading,
    required double width,
    required double height,
  }) : child = _SquareBone.textLine(width: width, height: height);

  final bool isLoading;
  final Widget child;

  @override
  State<OptimusBone> createState() => _OptimusBoneState();
}

class _OptimusBoneState extends State<OptimusBone> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges case final shimmerChanges?) {
      shimmerChanges.removeListener(_onShimmerChange);
    }
    _shimmerChanges = OptimusSkeleton.of(context)?.shimmerController;
    if (_shimmerChanges case final shimmerChanges?) {
      shimmerChanges.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final shimmer = OptimusSkeleton.of(context);
    if (shimmer != null && shimmer.isSized) {
      final renderObject = context.findRenderObject();
      Offset? offsetWithinShimmer;
      if (renderObject is RenderBox) {
        offsetWithinShimmer = shimmer.getDescendantOffset(
          descendant: renderObject,
        );
      }

      if (offsetWithinShimmer case final offset?) {
        final shimmerSize = shimmer.size;
        final gradient = shimmer.gradient;

        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback:
              (_) => gradient.createShader(
                Rect.fromLTWH(
                  -offset.dx,
                  -offset.dy,
                  shimmerSize.width,
                  shimmerSize.height,
                ),
              ),
          child: widget.child,
        );
      }
    }

    return const SizedBox();
  }
}

enum _SquareRadiusVariant { square, rounded }

class _SquareBone extends StatelessWidget {
  const _SquareBone({
    required this.width,
    required this.height,
    required this.radiusVariant,
  });

  const _SquareBone.square({required double width, required double height})
    : this(
        width: width,
        height: height,
        radiusVariant: _SquareRadiusVariant.square,
      );

  const _SquareBone.textLine({required double width, required double height})
    : this(
        width: width,
        height: height,
        radiusVariant: _SquareRadiusVariant.rounded,
      );

  final double width;
  final double height;
  final _SquareRadiusVariant radiusVariant;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(radiusVariant.toRadius(context)),
      ),
    ),
  );
}

extension on _SquareRadiusVariant {
  Radius toRadius(BuildContext context) => switch (this) {
    _SquareRadiusVariant.square => context.tokens.borderRadius150,
    _SquareRadiusVariant.rounded => context.tokens.borderRadiusRound,
  };
}

extension on BuildContext {
  LinearGradient get linearGradient => LinearGradient(
    // ignore: avoid-duplicate-collection-elements, gradient colors
    colors: [backgroundColor, tokens.backgroundStaticFlat, backgroundColor],
    stops: const [0.1, 0.3, 0.4],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    tileMode: TileMode.clamp,
  );

  Color get backgroundColor => tokens.backgroundInteractiveNeutralDefault;
}
