import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OptimusSlideAction extends StatelessWidget {
  const OptimusSlideAction({
    Key? key,
    required this.child,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => CustomSlidableAction(
        backgroundColor: color,
        onPressed: (_) => onTap(),
        child: child,
      );
}
