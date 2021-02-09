import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

typedef ShowNonModal = void Function({
  @required Widget title,
  @required Widget content,
  @required bool isDismissible,
});

typedef HideNonModal = void Function();

abstract class NonModalController {
  ShowNonModal get show;

  HideNonModal get hide;
}

class NonModalWrapper extends StatefulWidget {
  const NonModalWrapper({Key key, @required this.child}) : super(key: key);

  final Widget child;

  static NonModalController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NonModalWrapperData>();

  @override
  _NonModalWrapperState createState() => _NonModalWrapperState();
}

class _NonModalWrapperState extends State<NonModalWrapper> {
  OverlayEntry _entry;

  void _show({
    @required Widget title,
    @required Widget content,
    @required bool isDismissible,
  }) {
    _hide();
    _entry = OverlayEntry(
        builder: (context) => OptimusDialog(
              title: title,
              content: content,
              close: _hide,
              isDismissible: isDismissible,
            ));
    Overlay.of(context).insert(_entry);
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void deactivate() {
    _hide();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) => NonModalWrapperData(
        show: _show,
        hide: _hide,
        child: widget.child,
      );
}

class NonModalWrapperData extends InheritedWidget
    implements NonModalController {
  const NonModalWrapperData({
    Key key,
    @required this.show,
    @required this.hide,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  final ShowNonModal show;

  @override
  final HideNonModal hide;

  @override
  bool updateShouldNotify(NonModalWrapperData oldWidget) => false;
}
