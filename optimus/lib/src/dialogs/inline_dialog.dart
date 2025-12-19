import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/dialogs/dialog_content.dart';

/// A dialog that is anchored to a specific widget.
///
/// The dialog is used in cases where a user needs to make a local change or
/// display extra information while keeping the main content still visible.
class OptimusInlineDialog extends StatelessWidget {
  const OptimusInlineDialog({
    super.key,
    required this.content,
    this.contentWrapperBuilder,
    this.actions = const [],
    this.close,
    this.size = OptimusDialogSize.small,
    required this.anchorKey,
  });

  /// Key of the widget that the dialog should be anchored to.
  final GlobalKey anchorKey;

  /// {@macro optimus.dialog.wrapper}
  final ContentWrapperBuilder? contentWrapperBuilder;

  /// {@macro optimus.dialog.actions}
  final List<OptimusDialogAction> actions;

  /// The size of the dialog.
  final OptimusDialogSize size;

  final VoidCallback? close;
  final Widget content;

  @override
  Widget build(BuildContext context) => AnchoredOverlay(
    anchorKey: anchorKey,
    width: size.width,
    child: DialogContent(
      content: content,
      actions: actions,
      type: .common,
      size: size,
      maxWidth: size.width,
      contentWrapperBuilder: contentWrapperBuilder,
      isDismissible: true,
      close: close,
    ),
  );
}
