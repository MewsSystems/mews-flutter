import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:optimus/src/borders.dart';

class OptimusSlidable extends StatefulWidget {
  const OptimusSlidable({
    Key? key,
    required this.child,
    this.actions = const <Widget>[],
    this.isEnabled = true,
    this.hasBorders = true,
    this.actionsWidth = 0,
  }) : super(key: key);

  final Widget child;
  final List<Widget> actions;
  final bool isEnabled;
  final bool hasBorders;
  final double actionsWidth;

  @override
  _OptimusSlidableState createState() => _OptimusSlidableState();
}

class _OptimusSlidableState extends State<OptimusSlidable> {
  double _extentRatio = 1;

  void _afterLayout() {
    if (!mounted) return;
    final size = context.size;
    if (size != null) {
      final ratio = widget.actionsWidth > 0
          ? widget.actionsWidth / size.width
          : size.height / size.width;
      if (_extentRatio != ratio) {
        setState(() => _extentRatio = ratio);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _afterLayout());

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: _extentRatio,
      secondaryActions: widget.actions,
      enabled: widget.isEnabled,
      child:
          // ignore: deprecated_member_use_from_same_package
          widget.hasBorders ? TileBorders(child: widget.child) : widget.child,
    );
  }
}
