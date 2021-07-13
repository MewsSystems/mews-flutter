import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/breakpoint.dart';
import 'package:optimus/src/common/scroll.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';

enum OptimusDialogSize {
  /// Intended for short, to the point messages.
  ///
  /// Not suitable for dialogs with a lot of UI elements. Mostly used for
  /// non-modal dialogs to deliver users a message without preventing them from
  /// interacting with the application. Footers in small dialogs use only
  /// vertical button groups.
  small,

  /// The most common dialog size.
  ///
  /// Suitable for any content except those with very complex UI.
  regular,

  /// Intended for dialogs with complex UI elements (tables, forms with multiple
  /// columns, etc.) or large components like images.
  ///
  /// It can only be used as a modal dialog with centered position.
  large,
}

enum OptimusDialogType {
  /// Default dialog type. Used for common action.
  common,

  /// Primary button has [OptimusDialogType.destructive] variant, used for
  /// destructive actions.
  destructive,
}

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
    this.isPrimary = false,
    this.key,
  });

  final Widget title;
  final VoidCallback? onPressed;
  final bool isPrimary;
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
  bool hasCrossButton = true,
}) =>
    showGeneralDialog(
      context: context,
      pageBuilder: (buildContext, animation, secondaryAnimation) => SafeArea(
        child: OptimusDialog.modal(
          title: title,
          content: content,
          contentWrapperBuilder: contentWrapperBuilder,
          actions: actions,
          size: size,
          type: type,
          hasCrossButton: hasCrossButton,
        ),
      ),
      barrierDismissible: isDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: OptimusTheme.of(context).colors.neutral1000t64,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildTransitions,
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
    required this.hasCrossButton,
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
    required bool hasCrossButton,
  }) : this._(
          key: key,
          title: title,
          content: content,
          contentWrapperBuilder: contentWrapperBuilder,
          actions: actions,
          size: size,
          type: type,
          isDismissible: isDismissible,
          hasCrossButton: hasCrossButton,
        );

  const OptimusDialog.nonModal({
    Key? key,
    required Widget title,
    required Widget content,
    ContentWrapperBuilder? contentWrapperBuilder,
    List<OptimusDialogAction> actions = const [],
    OptimusDialogSize size = OptimusDialogSize.regular,
    required bool hasCrossButton,
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
          isDismissible: false,
          hasCrossButton: hasCrossButton,
          close: close,
          position: OptimusDialogPosition.corner,
        );

  final VoidCallback? close;
  final bool? isDismissible;
  final bool hasCrossButton;
  final OptimusDialogPosition position;

  /// Serves as an identification of the action in the dialog. Can be
  /// a sentence, question, or just a subject.
  final Widget title;

  final Widget content;

  /// Builds custom content. If content padding needed wrap in
  /// [OptimusDialogContentPadding].
  final ContentWrapperBuilder? contentWrapperBuilder;

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
  final List<OptimusDialogAction> actions;

  /// Controls dialog size.
  ///
  /// If screen size is small ([Breakpoint.small] or less), this parameter is
  /// ignored and [OptimusDialogSize.small] is always used.
  final OptimusDialogSize size;

  final OptimusDialogType type;

  Widget _divider(OptimusThemeData theme) =>
      Divider(height: 1, color: theme.colors.neutral50);

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

  double _maxWidth(OptimusDialogSize autoSize) {
    switch (autoSize) {
      case OptimusDialogSize.small:
        return 320;
      case OptimusDialogSize.regular:
        return 576;
      case OptimusDialogSize.large:
        return 896;
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
    final autoSize = _autoSize(context);
    final theme = OptimusTheme.of(context);

    return SafeArea(
      child: Align(
        alignment: _alignment(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: spacing300,
            vertical: spacing300,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: _maxWidth(autoSize)),
            child: OptimusCard(
              variant: OptimusBasicCardVariant.overlay,
              padding: OptimusCardSpacing.spacing0,
              child: Material(
                color: theme.isDark
                    ? theme.colors.neutral500
                    : theme.colors.neutral0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _Title(
                      context: context,
                      title: title,
                      close: close ?? () => Navigator.pop(context),
                      hasCrossButton: hasCrossButton,
                    ),
                    _divider(theme),
                    OptimusParagraph(
                      child: _Content(
                        content: content,
                        contentWrapperBuilder: contentWrapperBuilder,
                      ),
                    ),
                    if (actions.isNotEmpty) _divider(theme),
                    if (actions.isNotEmpty)
                      _Actions(
                        actions: actions,
                        type: type,
                        dialogSize: autoSize,
                        close: close ?? () => Navigator.pop(context),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
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

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.content,
    this.contentWrapperBuilder,
  }) : super(key: key);

  final Widget content;
  final ContentWrapperBuilder? contentWrapperBuilder;

  @override
  Widget build(BuildContext context) {
    final wrappedContent = contentWrapperBuilder == null
        ? OptimusScrollConfiguration(
            child: SingleChildScrollView(
              child: OptimusDialogContentPadding(child: content),
            ),
          )
        : contentWrapperBuilder!(context, content);

    return Flexible(
      fit: FlexFit.loose,
      child: wrappedContent,
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.context,
    required this.title,
    required this.close,
    required this.hasCrossButton,
  }) : super(key: key);

  final BuildContext context;
  final Widget title;
  final VoidCallback close;
  final bool hasCrossButton;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(spacing200),
              child: OptimusSubsectionTitle(child: title),
            ),
          ),
          if (hasCrossButton)
            Padding(
              padding: const EdgeInsets.only(top: spacing50),
              child: OptimusIconButton(
                icon: const OptimusIcon(iconData: OptimusIcons.cross_close),
                variant: OptimusIconButtonVariant.bare,
                onPressed: close,
              ),
            ),
        ],
      );
}

class _Actions extends StatelessWidget {
  const _Actions({
    Key? key,
    required this.actions,
    required this.dialogSize,
    required this.type,
    required this.close,
  }) : super(key: key);

  final List<OptimusDialogAction> actions;
  final OptimusDialogSize dialogSize;
  final OptimusDialogType type;
  final VoidCallback close;

  bool get _isVertical => dialogSize == OptimusDialogSize.small;

  @override
  Widget build(BuildContext context) {
    final children = actions
        .mapIndexed<Widget>(
          (i, e) => Padding(
            padding: EdgeInsets.only(
              bottom: _isVertical ? spacing200 : 0,
              left: _isVertical ? 0 : spacing200,
            ),
            child: OptimusButton(
              onPressed: e.onPressed ?? close,
              minWidth: _isVertical ? double.infinity : null,
              variant: _getVariant(i, e.isPrimary),
              key: e.key,
              child: e.title,
            ),
          ),
        )
        .toList();
    if (children.length > 2 && !_isVertical) {
      children.insert(2, const Spacer());
    }

    return Padding(
      padding: EdgeInsets.only(
        left: _isVertical ? spacing200 : 0,
        right: spacing200,
        top: spacing200,
        bottom: _isVertical ? 0 : spacing200,
      ),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.end,
        direction: _isVertical ? Axis.vertical : Axis.horizontal,
        children: children.reversed.toList(),
      ),
    );
  }

  OptimusButtonVariant _getVariant(int i, bool isPrimary) {
    if (actions.length == 1) {
      return isPrimary
          ? OptimusButtonVariant.primary
          : OptimusButtonVariant.defaultButton;
    }
    if (type == OptimusDialogType.destructive && i == 0) {
      return OptimusButtonVariant.destructive;
    }
    if (i == 0) return OptimusButtonVariant.primary;
    if (i == 1) return OptimusButtonVariant.defaultButton;
    return OptimusButtonVariant.text;
  }
}

Widget _buildTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) =>
    FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
