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

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final title = this.title;
    final content = this.content;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: .all(spacing ?? tokens.spacing0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: OptimusCard(
            variant: .overlay,
            padding: .spacing0,
            isOutlined: false,
            child: Material(
              color: tokens.backgroundStaticFloating,
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: <Widget>[
                  if (title != null)
                    _Title(
                      title: title,
                      close: close ?? () => Navigator.pop(context),
                      isDismissible:
                          isDismissible ??
                          ModalRoute.of(context)?.barrierDismissible ??
                          true,
                    ),
                  if (content != null)
                    OptimusParagraph(
                      child: _Content(
                        content: content,
                        contentWrapperBuilder: contentWrapperBuilder,
                      ),
                    ),
                  if (actions.isNotEmpty)
                    _Actions(
                      actions: actions,
                      type: type,
                      dialogSize: size,
                      close: close ?? () => Navigator.pop(context),
                    ),
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
  const _Content({required this.content, this.contentWrapperBuilder});

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

    return Flexible(fit: .loose, child: wrappedContent);
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
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Padding(
            padding: .all(tokens.spacing200),
            child: OptimusTitleSmall(child: title),
          ),
        ),
        if (isDismissible)
          Padding(
            padding: .only(top: tokens.spacing200, right: tokens.spacing200),
            child: OptimusIconButton(
              icon: const OptimusIcon(iconData: OptimusIcons.cross_close),
              size: .small,
              variant: .tertiary,
              onPressed: close,
            ),
          ),
      ],
    );
  }
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

  bool get _isVertical => dialogSize == .small;

  OptimusButtonVariant _getVariant(int i) {
    if (type == .destructive && i == 0) {
      return .danger;
    }
    if (i == 0) return .primary;
    if (i == 1) return .tertiary;

    return .ghost;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final children = actions
        .mapIndexed<Widget>(
          (i, e) => Padding(
            padding: .only(
              bottom: _isVertical ? tokens.spacing200 : tokens.spacing0,
              left: _isVertical ? tokens.spacing0 : tokens.spacing200,
            ),
            child: OptimusButton(
              onPressed: e.onPressed ?? close,
              minWidth: _isVertical ? .infinity : null,
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
      padding: .only(
        left: _isVertical ? tokens.spacing200 : tokens.spacing0,
        right: tokens.spacing200,
        top: tokens.spacing200,
        bottom: _isVertical ? tokens.spacing0 : tokens.spacing200,
      ),
      child: Flex(
        mainAxisAlignment: .end,
        direction: _isVertical ? .vertical : .horizontal,
        children: children.reversed.toList(),
      ),
    );
  }
}
