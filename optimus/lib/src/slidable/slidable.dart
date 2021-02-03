import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:optimus/src/borders.dart';

class OptimusSlidable extends StatefulWidget {
  const OptimusSlidable({
    Key key,
    @required this.child,
    this.actions = const <Widget>[],
    this.isEnabled = true,
    this.hasBorders = true,
  }) : super(key: key);

  final Widget child;
  final List<Widget> actions;
  final bool isEnabled;
  final bool hasBorders;

  @override
  _OptimusSlidableState createState() => _OptimusSlidableState();
}

class _OptimusSlidableState extends State<OptimusSlidable> {
  double _extentRatio = 1;

  void _afterLayout() {
    if (context != null) {
      final ratio = context.size.height / context.size.width;
      if (_extentRatio != ratio) {
        setState(() => _extentRatio = ratio);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout());

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: _extentRatio,
      secondaryActions: widget.actions,
      enabled: widget.isEnabled,
      child: widget.hasBorders ? TileBorders(child: widget.child) : widget.child,
    );
  }
}
