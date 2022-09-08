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
    Key? key,
    required this.content,
    this.contentWrapperBuilder,
    this.actions = const [],
    this.close,
    required this.anchorKey,
  }) : super(key: key);

  /// Key of the widget that the dialog should be anchored to.
  final GlobalKey anchorKey;

  /// {@macro optimus.dialog.wrapper}
  final ContentWrapperBuilder? contentWrapperBuilder;

  /// {@macro optimus.dialog.actions}
  final List<OptimusDialogAction> actions;

  final VoidCallback? close;
  final Widget content;

  @override
  Widget build(BuildContext context) => AnchoredOverlay(
        anchorKey: anchorKey,
        width: OptimusDialogSize.small.width,
        child: DialogContent(
          content: content,
          actions: actions,
          type: OptimusDialogType.common,
          size: OptimusDialogSize.small,
          maxWidth: OptimusDialogSize.small.width,
          contentWrapperBuilder: contentWrapperBuilder,
          isDismissible: true,
          close: close,
        ),
      );
}
