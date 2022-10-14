import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

abstract class DialogController {
  void show({
    required Widget title,
    required Widget content,
    bool isDismissible = true,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
    bool rootOverlay = false,
  });

  void showInline({
    required GlobalKey anchorKey,
    required Widget content,
    List<OptimusDialogAction> actions = const [],
    bool rootOverlay = false,
  });

  void hide();
}

class DialogWrapper extends StatefulWidget {
  const DialogWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static DialogController? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DialogWrapperData>()
      ?.controller;

  @override
  State<DialogWrapper> createState() => _DialogWrapperState();
}

class _DialogWrapperState extends State<DialogWrapper>
    implements DialogController {
  OverlayEntry? _entry;

  @override
  void didUpdateWidget(DialogWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child) {
      hide();
    }
  }

  @override
  void show({
    required Widget title,
    required Widget content,
    bool isDismissible = true,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
    bool rootOverlay = false,
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
    Overlay.of(context, rootOverlay: rootOverlay)?.insert(entry);
  }

  @override
  void showInline({
    required GlobalKey anchorKey,
    required Widget content,
    List<OptimusDialogAction> actions = const [],
    bool rootOverlay = false,
  }) {
    hide();
    final entry = OverlayEntry(
      builder: (context) => Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: hide,
          ),
          OptimusInlineDialog(
            content: content,
            close: hide,
            actions: actions,
            anchorKey: anchorKey,
          ),
        ],
      ),
    );
    _entry = entry;
    Overlay.of(context, rootOverlay: rootOverlay)?.insert(entry);
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
  Widget build(BuildContext context) =>
      DialogWrapperData(controller: this, child: widget.child);
}

class DialogWrapperData extends InheritedWidget {
  const DialogWrapperData({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final DialogController controller;

  @override
  bool updateShouldNotify(DialogWrapperData oldWidget) => false;
}
