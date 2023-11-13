import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OptimusSlideAction extends StatelessWidget {
  const OptimusSlideAction({
    super.key,
    required this.child,
    required this.color,
    required this.onTap,
  });

  final Widget child;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => CustomSlidableAction(
        backgroundColor: color,
        onPressed: (_) => onTap(),
        child: child,
      );
}
