import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NonModalWrapper extends InheritedWidget {
  NonModalWrapper({
    Key key,
    @required this.context,
    @required Widget child,
  }) : super(key: key, child: child);

  final BuildContext context;

  OverlayEntry _entry;

  void show({@required Widget child}) {
    if (_entry != null) return;
    _entry = OverlayEntry(builder: (context) => _Content(child: child));
    Overlay.of(context).insert(_entry);
  }

  void hide() {
    if (_entry != null) _entry.remove();
    _entry = null;
  }

  @override
  bool updateShouldNotify(NonModalWrapper oldWidget) => false;

  static NonModalWrapper of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NonModalWrapper>();
}

class _Content extends StatelessWidget {
  const _Content({
    this.child,
    Key key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      );
}
