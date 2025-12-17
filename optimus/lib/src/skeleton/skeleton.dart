import 'package:flutter/widgets.dart';
import 'package:optimus/src/common/semantics.dart';
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
  OptimusSkeletonState createState() => .new();
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
  LinearGradient get gradient => .new(
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
    Offset offset = .zero,
  }) {
    final shimmerBox = context.findRenderObject();

    return shimmerBox is RenderBox
        ? descendant.localToGlobal(offset, ancestor: shimmerBox)
        : Offset.zero;
  }

  // ignore: prefer-widget-private-members, required for the sync
  Listenable get shimmerController => _shimmerController;

  @override
  Widget build(BuildContext context) =>
      widget.child ?? const SizedBox().excludeSemantics();
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      .translationValues(bounds.width * slidePercent, 0.0, 0.0);
}

extension on BuildContext {
  LinearGradient get linearGradient => .new(
    colors: [
      backgroundColor,
      tokens.backgroundInteractiveNeutralBoldDefault,
      // ignore: avoid-duplicate-collection-elements, gradient colors
      backgroundColor,
    ],
    stops: const [0.1, 0.3, 0.4],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    tileMode: .clamp,
  );

  Color get backgroundColor => tokens.backgroundInteractiveNeutralDefault;
}
