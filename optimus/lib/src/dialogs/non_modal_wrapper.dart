import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

abstract class NonModalController {
  void show({
    required Widget title,
    required Widget content,
    bool isDismissible = true,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
  });

  void hide();
}

class NonModalWrapper extends StatefulWidget {
  const NonModalWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static NonModalController? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<NonModalWrapperData>()
      ?.controller;

  @override
  _NonModalWrapperState createState() => _NonModalWrapperState();
}

class _NonModalWrapperState extends State<NonModalWrapper>
    implements NonModalController {
  OverlayEntry? _entry;

  @override
  void show({
    required Widget title,
    required Widget content,
    bool isDismissible = true,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
  }) {
    hide();
    final entry = OverlayEntry(
      builder: (context) => OptimusDialog.nonModal(
        title: title,
        content: content,
        close: hide,
        isDismissible: isDismissible,
        actions: actions,
        size: size,
      ),
    );
    _entry = entry;
    Overlay.of(context, rootOverlay: true)?.insert(entry);
  }

  @override
  void hide() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void deactivate() {
    hide();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) => NonModalWrapperData(
        controller: this,
        child: widget.child,
      );
}

class NonModalWrapperData extends InheritedWidget {
  const NonModalWrapperData({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final NonModalController controller;

  @override
  bool updateShouldNotify(NonModalWrapperData oldWidget) => false;
}
