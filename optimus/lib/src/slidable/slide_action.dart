import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OptimusSlideAction extends StatelessWidget {
  const OptimusSlideAction({
    super.key,
    required this.child,
    required this.color,
    this.onTap,
    this.semanticLabel,
  });

  final Widget child;
  final String? semanticLabel;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => CustomSlidableAction(
    backgroundColor: color,
    onPressed: onTap == null ? null : (_) => onTap?.call(),
    child: Semantics(label: semanticLabel, child: child),
  );
}
