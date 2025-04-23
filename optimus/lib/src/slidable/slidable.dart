import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:optimus/src/borders.dart';

class OptimusSlidable extends StatefulWidget {
  const OptimusSlidable({
    super.key,
    required this.child,
    this.actions = const <Widget>[],
    this.isEnabled = true,
    this.hasBorders = true,
    this.actionsWidth = 0,
  });

  final Widget child;
  final List<Widget>? actions;
  final bool isEnabled;
  final bool hasBorders;
  final double actionsWidth;

  @override
  State<OptimusSlidable> createState() => _OptimusSlidableState();
}

class _OptimusSlidableState extends State<OptimusSlidable> {
  double _extentRatio = 1;

  void _afterLayout() {
    if (!mounted) return;

    // context.size returns nullable size, but we can't use it here,
    // because RenderBox overrides size and force unwraps it.
    // We need to check first if the size is not null using
    // RenderBox.hasSize property.
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final size = renderObject.size;
    final ratio =
        widget.actionsWidth > 0
            ? widget.actionsWidth / size.width
            : size.height / size.width;
    if (_extentRatio != ratio) {
      setState(() => _extentRatio = ratio);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout());

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: _extentRatio,
        children: widget.actions ?? [],
      ),
      enabled: widget.isEnabled,
      child:
          widget.hasBorders ? TileBorders(child: widget.child) : widget.child,
    );
  }
}
