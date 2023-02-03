import 'package:flutter/widgets.dart';

/// Removes platform native animations from scroll.
class OptimusScrollConfiguration extends StatelessWidget {
  const OptimusScrollConfiguration({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => ScrollConfiguration(
        behavior: _OptimusScrollBehaviour(),
        child: child,
      );
}

class _OptimusScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;
}
