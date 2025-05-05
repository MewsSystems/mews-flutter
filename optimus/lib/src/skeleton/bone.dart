import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/skeleton/skeleton.dart';
import 'package:optimus/src/theme/theme.dart';

/// A widget that displays a loading skeleton when the `isLoading` is true.
/// For pre-built shapes, use [OptimusBone.card], [OptimusBone.circle],
/// or [OptimusBone.text].
class OptimusBone extends StatelessWidget {
  const OptimusBone({Key? key, required Widget child, bool isLoading = true})
    : this._(key: key, child: child, isLoading: isLoading);

  const OptimusBone.card({
    Key? key,
    required double width,
    required double height,
  }) : this._(
         key: key,
         width: width,
         height: height,
         radiusVariant: OptimusBoneRadiusVariant.square,
       );

  const OptimusBone.circle({Key? key, required double diameter})
    : this._(
        key: key,
        width: diameter,
        height: diameter,
        boxShape: BoxShape.circle,
      );

  const OptimusBone.text({
    Key? key,
    required double width,
    required double fontSize,
    OptimusBoneRadiusVariant radiusVariant = OptimusBoneRadiusVariant.rounded,
  }) : this._(
         key: key,
         width: width,
         height: fontSize,
         radiusVariant: radiusVariant,
       );

  const OptimusBone._({
    super.key,
    this.width,
    this.height,
    this.radiusVariant,
    this.boxShape = BoxShape.rectangle,
    this.child,
    this.isLoading = true,
  });

  final double? width;
  final double? height;
  final OptimusBoneRadiusVariant? radiusVariant;
  final BoxShape? boxShape;
  final Widget? child;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) => _Bone(
    isLoading: isLoading ?? true,
    child:
        child ??
        SizedBox(
          width: width,
          height: height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: boxShape ?? BoxShape.rectangle,
              color: context.tokens.backgroundStaticFlat,
              borderRadius: radiusVariant?.let(
                (variant) => BorderRadius.all(variant.toRadius(context)),
              ),
            ),
          ),
        ),
  );
}

enum OptimusBoneRadiusVariant { square, rounded }

class _Bone extends StatefulWidget {
  const _Bone({this.isLoading = true, required this.child});

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

extension on OptimusBoneRadiusVariant {
  Radius toRadius(BuildContext context) => switch (this) {
    OptimusBoneRadiusVariant.square => context.tokens.borderRadius150,
    OptimusBoneRadiusVariant.rounded => context.tokens.borderRadius300,
  };
}
