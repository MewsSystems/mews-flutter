import 'package:flutter/widgets.dart';

/// Removes platform native animations from scroll.
class OptimusScrollConfiguration extends StatelessWidget {
  const OptimusScrollConfiguration({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => ScrollConfiguration(
        behavior: const _OptimusScrollBehaviour(),
        child: child,
      );
}

class _OptimusScrollBehaviour extends ScrollBehavior {
  const _OptimusScrollBehaviour();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}
