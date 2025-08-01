import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

abstract class DialogController {
  const DialogController();

  void show({
    required Widget title,
    required Widget content,
    bool isDismissible = true,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
    bool useRootOverlay = false,
  });

  void showInline({
    required GlobalKey anchorKey,
    required Widget content,
    OptimusDialogSize size = OptimusDialogSize.small,
    List<OptimusDialogAction> actions = const [],
    bool useRootOverlay = false,
  });

  void hide();
}

class OptimusDialogWrapper extends StatefulWidget {
  const OptimusDialogWrapper({super.key, required this.child});

  final Widget child;

  static DialogController? of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<DialogWrapperData>()
          ?.controller;

  @override
  State<OptimusDialogWrapper> createState() => OptimusDialogWrapperState();
}

class OptimusDialogWrapperState extends State<OptimusDialogWrapper>
    implements DialogController {
  OverlayEntry? _entry;

  @override
  void didUpdateWidget(OptimusDialogWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child) {
      hide();
    }
  }

  @override
  void dispose() {
    _entry?.dispose();
    super.dispose();
  }

  void _handleClose() => hide();

  @override
  void show({
    required Widget title,
    required Widget content,
    bool isDismissible = true,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
    bool useRootOverlay = false,
  }) {
    hide();
    final entry = OverlayEntry(
      builder:
          (_) => MediaQuery(
            data: MediaQuery.of(context),
            child: OptimusDialog.nonModal(
              title: title,
              content: content,
              close: _handleClose,
              isDismissible: isDismissible,
              actions: actions,
              size: size,
            ),
          ),
    );
    _entry = entry;
    Overlay.of(context, rootOverlay: useRootOverlay).insert(entry);
  }

  @override
  void showInline({
    required GlobalKey anchorKey,
    required Widget content,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.small,
    bool useRootOverlay = false,
  }) {
    hide();
    final entry = OverlayEntry(
      builder:
          (_) => MediaQuery(
            data: MediaQuery.of(context),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _handleClose,
                ),
                OptimusInlineDialog(
                  content: content,
                  close: _handleClose,
                  actions: actions,
                  anchorKey: anchorKey,
                  size: size,
                ),
              ],
            ),
          ),
    );
    _entry = entry;
    Overlay.of(context, rootOverlay: useRootOverlay).insert(entry);
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
    super.key,
    required this.controller,
    required super.child,
  });

  final DialogController controller;

  @override
  bool updateShouldNotify(DialogWrapperData oldWidget) => false;
}
