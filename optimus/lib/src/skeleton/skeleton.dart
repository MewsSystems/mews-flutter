import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';

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
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  // ignore: prefer-widget-private-members, has to be public for the sync
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

class OptimusBone extends StatefulWidget {
  const OptimusBone({super.key, required this.isLoading, required this.child});

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
      setState(() {
        // Update the shimmer painting.
      });
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
              (bounds) => gradient.createShader(
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

extension on BuildContext {
  LinearGradient get linearGradient => LinearGradient(
    colors: [
      tokens.backgroundStaticFlat.withValues(alpha: tokens.opacity100),
      tokens.backgroundStaticFlat.withValues(alpha: tokens.opacity400),
      tokens.backgroundStaticFlat.withValues(alpha: tokens.opacity100),
    ],
    stops: const [0.1, 0.3, 0.4],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    tileMode: TileMode.clamp,
  );
}
