import 'package:flutter/widgets.dart';
import 'package:optimus/src/skeleton/skeleton.dart';
import 'package:optimus/src/theme/theme.dart';

/// A widget that displays a loading skeleton when the `isLoading` is true.
///
class OptimusBone extends StatelessWidget {
  const OptimusBone({super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      _Bone(isLoading: isLoading, child: child);
}

class OptimusBoneCircle extends StatelessWidget {
  const OptimusBoneCircle({
    super.key,
    required this.isLoading,
    required this.size,
  });

  final double size;
  final bool isLoading;

  @override
  Widget build(BuildContext context) =>
      _CircleBone(isLoading: isLoading, size: size);
}

class OptimusBoneSquare extends StatelessWidget {
  const OptimusBoneSquare({
    super.key,
    required this.isLoading,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => _SquareBone(
    width: width,
    height: height,
    isLoading: isLoading,
    radiusVariant: _SquareRadiusVariant.square,
  );
}

class OptimusBoneText extends StatelessWidget {
  const OptimusBoneText({
    super.key,
    required this.isLoading,
    required this.width,
    required this.height,
  });

  final bool isLoading;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => _SquareBone(
    width: width,
    height: height,
    isLoading: isLoading,
    radiusVariant: _SquareRadiusVariant.rounded,
  );
}

class _Bone extends StatefulWidget {
  const _Bone({required this.isLoading, required this.child});

  final Widget child;
  final bool isLoading;

  @override
  State<StatefulWidget> createState() => _BoneState();
}

class _BoneState extends State<_Bone> {
  Listenable? _shimmerChanges;

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
}

class _CircleBone extends StatelessWidget {
  const _CircleBone({required this.isLoading, required this.size});

  final double size;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => _Bone(
    isLoading: isLoading,
    child: SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.tokens.backgroundStaticFlat,
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}

class _SquareBone extends StatelessWidget {
  const _SquareBone({
    required this.width,
    required this.height,
    required this.isLoading,
    required this.radiusVariant,
  });

  final double width;
  final double height;
  final bool isLoading;
  final _SquareRadiusVariant radiusVariant;

  @override
  Widget build(BuildContext context) => _Bone(
    isLoading: isLoading,
    child: SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.tokens.backgroundStaticFlat,
          borderRadius: BorderRadius.all(radiusVariant.toRadius(context)),
        ),
      ),
    ),
  );
}

enum _SquareRadiusVariant { square, rounded }

extension on _SquareRadiusVariant {
  Radius toRadius(BuildContext context) => switch (this) {
    _SquareRadiusVariant.square => context.tokens.borderRadius150,
    _SquareRadiusVariant.rounded => context.tokens.borderRadiusRound,
  };
}
