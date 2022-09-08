import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/dialogs/dialog_content.dart';

/// The position of a dialog is determined by functionality.
enum OptimusDialogPosition {
  /// Centered dialogs direct user attention to their content in order to make
  /// users focus on a single task within them. They are used in combination
  /// with modal behavior.
  center,

  /// Corner dialogs usually deliver non-vital messages to users. These dialogs
  /// are non-modal and keep their position when scrolling a page.
  corner,
}

class OptimusDialogAction {
  const OptimusDialogAction({
    required this.title,
    this.onPressed,
    this.key,
  });

  final Widget title;
  final VoidCallback? onPressed;
  final Key? key;
}

/// [isDismissible] – If a dialog contains a close icon, it can also be closed
/// by clicking on background layer. Otherwise, only by buttons.
Future<T?> showOptimusDialog<T>({
  required BuildContext context,
  required Widget title,
  required Widget content,
  ContentWrapperBuilder? contentWrapperBuilder,
  List<OptimusDialogAction> actions = const [],
  OptimusDialogSize size = OptimusDialogSize.regular,
  OptimusDialogType type = OptimusDialogType.common,
  bool isDismissible = true,
}) =>
    showGeneralDialog(
      context: context,
      pageBuilder: (buildContext, animation, secondaryAnimation) =>
          OptimusDialog.modal(
        title: title,
        content: content,
        contentWrapperBuilder: contentWrapperBuilder,
        actions: actions,
        size: size,
        type: type,
      ),
      barrierDismissible: isDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: OptimusTheme.of(context).colors.neutral1000t64,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (_, animation, __, child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      ),
      useRootNavigator: true,
    );

/// A dialog is an overlay on top of a main page which lets a user perform
/// a short term task without losing the context of the underlying page.
class OptimusDialog extends StatelessWidget {
  const OptimusDialog._({
    Key? key,
    required this.title,
    required this.content,
    this.contentWrapperBuilder,
    this.actions = const [],
    this.size = OptimusDialogSize.regular,
    this.type = OptimusDialogType.common,
    this.close,
    this.isDismissible,
    this.position = OptimusDialogPosition.center,
  }) : super(key: key);

  const OptimusDialog.modal({
    Key? key,
    required Widget title,
    required Widget content,
    ContentWrapperBuilder? contentWrapperBuilder,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
    OptimusDialogType type = OptimusDialogType.common,
    bool? isDismissible,
  }) : this._(
          key: key,
          title: title,
          content: content,
          contentWrapperBuilder: contentWrapperBuilder,
          actions: actions,
          size: size,
          type: type,
          isDismissible: isDismissible,
        );

  const OptimusDialog.nonModal({
    Key? key,
    required Widget title,
    required Widget content,
    ContentWrapperBuilder? contentWrapperBuilder,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
    bool? isDismissible,
    required VoidCallback close,
  }) : this._(
          key: key,
          title: title,
          content: content,
          contentWrapperBuilder: contentWrapperBuilder,
          actions: actions,
          size: size == OptimusDialogSize.large
              ? OptimusDialogSize.regular
              : size,
          isDismissible: isDismissible,
          close: close,
          position: OptimusDialogPosition.corner,
        );

  final VoidCallback? close;
  final bool? isDismissible;
  final OptimusDialogPosition position;

  /// Serves as an identification of the action in the dialog. Can be
  /// a sentence, question, or just a subject.
  final Widget title;

  final Widget content;

  /// {@template optimus.dialog.wrapper}
  /// Builds custom content. If content padding needed wrap in
  /// [OptimusDialogContentPadding].
  /// {@endtemplate}
  final ContentWrapperBuilder? contentWrapperBuilder;

  /// {@template optimus.dialog.actions}
  /// Controls dialog actions.
  ///
  /// First button should always contain primary action. When single button it
  /// has [OptimusButtonVariant.defaultButton] variant, otherwise it has
  /// [OptimusButtonVariant.primary] variant for [OptimusDialogType.common] type
  /// or [OptimusButtonVariant.destructive] variant for
  /// [OptimusDialogType.destructive] type.
  ///
  /// Second button represents secondary action. It always has
  /// [OptimusButtonVariant.defaultButton] variant.
  ///
  /// All other buttons have [OptimusButtonVariant.text] variant and represent
  /// additional actions.
  /// {@endtemplate}
  final List<OptimusDialogAction> actions;

  /// Controls dialog size.
  ///
  /// If screen size is small ([Breakpoint.small] or less), this parameter is
  /// ignored and [OptimusDialogSize.small] is always used.
  final OptimusDialogSize size;

  final OptimusDialogType type;

  OptimusDialogSize _autoSize(BuildContext context) {
    switch (MediaQuery.of(context).screenBreakpoint) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
        return OptimusDialogSize.small;
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return size;
    }
  }

  Alignment _alignment(BuildContext context) {
    switch (MediaQuery.of(context).screenBreakpoint) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
        return _smallScreenAlignment;
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return _largeScreenAlignment;
    }
  }

  Alignment get _smallScreenAlignment {
    switch (position) {
      case OptimusDialogPosition.center:
        return Alignment.center;
      case OptimusDialogPosition.corner:
        return Alignment.topCenter;
    }
  }

  Alignment get _largeScreenAlignment {
    switch (position) {
      case OptimusDialogPosition.center:
        return Alignment.center;
      case OptimusDialogPosition.corner:
        return Alignment.bottomRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = _autoSize(context);

    return Align(
      alignment: _alignment(context),
      child: DialogContent(
        title: title,
        content: content,
        actions: actions,
        type: type,
        size: size,
        maxWidth: size.width,
        spacing: spacing300,
        margin: MediaQuery.of(context).viewInsets,
        contentWrapperBuilder: contentWrapperBuilder,
        isDismissible: isDismissible,
        close: close,
      ),
    );
  }
}

class OptimusDialogContentPadding extends StatelessWidget {
  const OptimusDialogContentPadding({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      Padding(padding: const EdgeInsets.all(spacing200), child: child);
}
