import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({
    super.key,
    required this.actions,
    required this.type,
    required this.size,
    required this.maxWidth,
    this.content,
    this.title,
    this.close,
    this.isDismissible,
    this.contentWrapperBuilder,
    this.spacing,
    this.margin,
  }) : assert(
          title != null || content != null,
          'Either title or content need to be provided',
        );

  final List<OptimusDialogAction> actions;
  final Widget? title;
  final double? spacing;
  final double maxWidth;
  final EdgeInsetsGeometry? margin;

  final Widget? content;
  final VoidCallback? close;
  final OptimusDialogSize size;
  final bool? isDismissible;
  final OptimusDialogType type;

  final ContentWrapperBuilder? contentWrapperBuilder;

  Widget _divider(OptimusThemeData theme) =>
      Divider(height: 1, color: theme.colors.neutral50);

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final title = this.title;
    final content = this.content;

    return Container(
      margin: margin,
      child: Padding(
        padding: EdgeInsets.all(spacing ?? 0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
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
                  if (title != null)
                    _Title(
                      title: title,
                      close: close ?? () => Navigator.pop(context),
                      isDismissible: isDismissible ??
                          ModalRoute.of(context)?.barrierDismissible ??
                          true,
                    ),
                  if (title != null && content != null) _divider(theme),
                  if (content != null)
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
                      dialogSize: size,
                      close: close ?? () => Navigator.pop(context),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.content,
    this.contentWrapperBuilder,
  });

  final Widget content;
  final ContentWrapperBuilder? contentWrapperBuilder;

  @override
  Widget build(BuildContext context) {
    final contentWrapperBuilder = this.contentWrapperBuilder;
    final wrappedContent = contentWrapperBuilder == null
        ? OptimusScrollConfiguration(
            child: SingleChildScrollView(
              child: OptimusDialogContentPadding(child: content),
            ),
          )
        : contentWrapperBuilder(context, content);

    return Flexible(fit: FlexFit.loose, child: wrappedContent);
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    required this.close,
    required this.isDismissible,
  });

  final Widget title;
  final VoidCallback close;
  final bool isDismissible;

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
          if (isDismissible)
            Padding(
              padding:
                  const EdgeInsets.only(top: spacing200, right: spacing200),
              child: OptimusIconButton(
                icon: const OptimusIcon(iconData: OptimusIcons.cross_close),
                size: OptimusWidgetSize.small,
                variant: OptimusButtonVariant.tertiary,
                onPressed: close,
              ),
            ),
        ],
      );
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.actions,
    required this.dialogSize,
    required this.type,
    required this.close,
  });

  final List<OptimusDialogAction> actions;
  final OptimusDialogSize dialogSize;
  final OptimusDialogType type;
  final VoidCallback close;

  bool get _isVertical => dialogSize == OptimusDialogSize.small;

  OptimusButtonVariant _getVariant(int i) {
    if (type == OptimusDialogType.destructive && i == 0) {
      return OptimusButtonVariant.danger;
    }
    if (i == 0) return OptimusButtonVariant.primary;
    if (i == 1) return OptimusButtonVariant.tertiary;

    return OptimusButtonVariant.ghost;
  }

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
              variant: _getVariant(i),
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
}
